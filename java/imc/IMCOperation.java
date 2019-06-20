package RestToDll.BO;

import java.math.BigDecimal;
import java.math.RoundingMode;

import com.intersystems.gateway.bh.BusinessOperation;
import com.intersystems.gateway.bh.Production;
import com.intersystems.gateway.bh.Production.Severity;

public class IMCOperation implements BusinessOperation {

	Production production = null;
	public static Thread messageThread = null;
	
	@Override
	public boolean OnInit(Production arg0) throws Exception {
		production = arg0;
		return true;
	}

	@Override
	public boolean OnTearDown() throws Exception {
		return true;
	}

	@Override
	public boolean OnMessage(String arg0) throws Exception {
		if (!isNullOrEmpty(arg0)) {
			String[] measure = arg0.split("\\s+");
			double weight = Double.parseDouble(measure[0]);
			double height = Double.parseDouble(measure[1]);
			height = height * 0.01;
			
			double imc = weight/(height*height);
			imc = round(imc, 1);
			
			//production.LogMessage("Received : " + arg0, Severity.INFO);
			
			if (messageThread == null) {
				Messager message = new Messager(imc);
				messageThread = new Thread(message);
				messageThread.start();
			}
		}
		return true;
	}

	public static boolean isNullOrEmpty(String s) {
		if (s != null && !s.isEmpty())
			return false;
		return true;
	}
	
	public static double round(double value, int decimals) {
		if (decimals < 0) {
			throw new IllegalArgumentException();
		}
		BigDecimal bd = new BigDecimal(value);
		bd = bd.setScale(decimals, RoundingMode.HALF_UP);
		return bd.doubleValue();
	}
	
	private class Messager implements Runnable {
	    public Double imc;
	    
	    public Messager(double imc) {
	    	this.imc = imc;
	    }
	      
	    public void run() {
	      try {
	        production.LogMessage("Calculated IMC : "+ this.imc, Severity.INFO);
	      
	        while (true) {
	          production.SendRequest(this.imc.toString());
	          Thread.sleep(5000);
	        }
	      } catch (InterruptedException e) {
	        try {
	          production.LogMessage("Shutting down", Severity.INFO);
	        } catch (Exception e1) {
	          e1.printStackTrace();
	        }
	        return;
	      } catch (Exception e) {
	        try {
	          production.LogMessage(e.toString(), Severity.ERROR);
	          production.SetStatus(Production.Status.ERROR);
	        } catch (Exception e1) {
	          e1.printStackTrace();
	        }
	      }
	    }  
	}
	

}
