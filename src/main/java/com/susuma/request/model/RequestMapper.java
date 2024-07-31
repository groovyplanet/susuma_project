package com.susuma.request.model;

import java.util.ArrayList;
import java.util.Map;

public interface RequestMapper {

	public ArrayList<RequestDTO> selectRequests(Map<String, Object> params); // [1] 수리 요청 목록

	public int countRequests(Map<String, Object> params); // [1-2] 수리 요청 목록 수(페이징 처리)

	public int getNewRequestCount(String meNo);

	public RequestDTO selectRequestCnts(Map<String, Object> params); // [1-3] 수리 상태별 개수

	public RequestDTO selectRequest(Map<String, Object> params); // [2] 수리 요청 1건

	public int insertRequest(RequestDTO dto); // [3] 수리 요청 등록

	public int updateRequest(RequestDTO dto); // [4] 수리 요청 수정

	public void deleteRequest(String reNo); // [5] 수리 요청 삭제

	public void updateRequestStatus(RequestDTO requestDTO);

}
