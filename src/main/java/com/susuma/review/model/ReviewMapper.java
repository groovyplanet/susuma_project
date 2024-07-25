package com.susuma.review.model;

import java.util.ArrayList;

import com.susuma.request.model.RequestDTO;

public interface ReviewMapper {
	
	public ArrayList<ReviewDTO> getList();
	void insertReview(ReviewDTO review);

}
