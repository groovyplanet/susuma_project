package com.susuma.point.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface PointMapper {
    Integer MemberPoints(String meNo);
    List<PointDTO> getPointEarnings(String meNo);
    List<PointDTO> getPointSpendings(String meNo);
    List<PointDTO> getWithdrawalHistory(String meNo);
    void updateMemberPoints(@Param("meNo") String meNo, @Param("point") int point);
    void addSpendingHistory(PointDTO pointDTO);
    void addEarningHistory(PointDTO pointDTO);
}
