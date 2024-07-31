package com.susuma.review.model;

import java.util.ArrayList;
import java.util.Map;

public interface ReviewMapper {

	public ArrayList<ReviewDTO> selectReviews(Map<String, Object> params); // [1] 리뷰 목록

	public int countReviews(Map<String, Object> params); // [1-2] 리뷰 목록 수(페이징 처리)

	public ReviewDTO selectReview(Map<String, Object> params); // [2] 리뷰 1건

	public int insertReview(ReviewDTO dto); // [3] 리뷰 등록

	public int updateReview(ReviewDTO dto); // [4] 리뷰 수정

	public void deleteReview(String reNo); // [5] 리뷰 삭제

}
