package com.susuma.alert.model;

import java.util.ArrayList;

public interface AlertMapper {

	public ArrayList<AlertDTO> selectAlerts(String meNo);

	public int getNewAlertCount(String meNo);

	public int insertAlert(AlertDTO dto);

	public int deleteAlert(String alNo);

}
