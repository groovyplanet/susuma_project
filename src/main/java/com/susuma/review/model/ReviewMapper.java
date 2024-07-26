package com.susuma.review.model;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.susuma.request.model.RequestDTO;

public interface ReviewMapper {
	
	public ArrayList<ReviewDTO> getList();
	public ArrayList<ReviewDTO> getLists(String meNo);
	void insertReview(ReviewDTO review);


}
