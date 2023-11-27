package vtravel;

public class ProposalCustomTour {
	private int ID;
	private int ordererID;
	private String destination;
	private String note;
	private String startDate;
	private String endDate;
	private int numberOfTravellers;
	private String status;
	private String createdDate;
	
	
	public ProposalCustomTour(int ordererID, String destination,  String startDate, String endDate,
			int numberOfTravellers, String note, String status) {
		super();
		this.ordererID = ordererID;
		this.destination = destination;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
		this.note = note;
		this.numberOfTravellers = numberOfTravellers;
	}
	
	
	public ProposalCustomTour(int ordererID, String destination,  String startDate, String endDate,
			int numberOfTravellers, String note, String status, String createdDate) {
		super();
		this.ordererID = ordererID;
		this.destination = destination;
		this.note = note;
		this.startDate = startDate;
		this.endDate = endDate;
		this.numberOfTravellers = numberOfTravellers;
		this.status = status;
		this.createdDate = createdDate;
	}

	//getters and setters
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public int getOrdererID() {
		return ordererID;
	}
	public void setOrdererID(int ordererID) {
		this.ordererID = ordererID;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public int getNumberOfTravellers() {
		return numberOfTravellers;
	}
	public void setNumberOfTravellers(int numberOfTravellers) {
		this.numberOfTravellers = numberOfTravellers;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	
		
}
