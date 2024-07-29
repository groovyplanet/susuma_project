<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

				<c:forEach var="dto" items="${memberList}">
					<a class="technician" style="text-decoration: none; color: black;" href="${pageContext.request.contextPath }/member/masterView.member?meNo=${dto.meNo}">
						<c:choose>
							<c:when test="${dto.profilePhotoImg == '' }">
								<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
							</c:when>
							<c:otherwise>
								<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
							</c:otherwise>
						</c:choose>
						<h3>${dto.name}</h3>
						<div class="master-info">
							<c:if test="${dto.reviewCount > 0}">
								<p class="master-stars">
									<i class="bi bi-star-fill gold"></i>
									<strong>${dto.averageScore }</strong>
									<span class="review-count">(${dto.reviewCount })</span>
								</p>
							</c:if>
							<p>
								<c:set var="addressParts" value="${fn:split(dto.address, ' ')}" />
								<i class="bi bi-geo-alt"></i>${addressParts[0]}
								${addressParts[1]} (${dto.maxDistance}km 이내 가능)
							</p>
							<p>
								<span class="master-category">
									<span>${dto.caRootName }
										<i class="bi bi-chevron-right"></i>${dto.caName }</span>
								</span>
							</p>
							<p>${dto.shortDescription }</p>
						</div>
					</a>
				</c:forEach>