package com.susuma.request.model;

import java.util.ArrayList;

public interface RequestMapper {

	public ArrayList<RequestDTO> getList();

	public int insertRequest(RequestDTO dto);

	
}
