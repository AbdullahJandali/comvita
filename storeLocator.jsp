<%--
   *  Copyright 2016, TekFactory. All Rights Reserved.
   *
   *  Reproduction or use of this file without express written
   *  consent is prohibited.
   *
   *  FILE:  storeLocator.jsp
   *
   *  DESCRIPTION: common page for login page  and other pages related to comvita login page content based on the conditions
   *
   *  HISTORY:
   *  Jan 4, 2017  Initial version
   *
   *  LO-FI: 
   *  HI-FI: 
   *
   --%>
<dsp:page>
<dsp:param name="pageName" value="StoreLocator"/>
<dsp:importbean bean="/com/sgs/cms/tools/SGSMediaIdsForPagesConfig"/>
<dsp:importbean bean="/atg/multisite/Site"/>
<dsp:getvalueof id="siteId" bean="Site.id" />
<dsp:getvalueof var="storeLocatorViaMediaMap" bean="SGSMediaIdsForPagesConfig.storeLocatorViaMedia"/>
<dsp:getvalueof var="mediaId"  bean="SGSMediaIdsForPagesConfig.mediaForStoreLocator"/> 

   <tek:main-layout>
   		<c:forEach var="storeLocatorViaMedia" items="${storeLocatorViaMediaMap}" varStatus="count">		
			<c:if test="${storeLocatorViaMedia.key eq siteId}">
				<c:set var="isStoreLocatorViaMedia" value="${storeLocatorViaMedia.value}"/>
			</c:if>
		</c:forEach>
	<c:choose>
		<c:when test="${isStoreLocatorViaMedia}">
			<dsp:droplet name="/atg/commerce/catalog/MediaLookup">
				 <dsp:param value="${mediaId}" name="id"/>
				 <dsp:oparam name="output">
				   <dsp:droplet name="/atg/dynamo/droplet/IsEmpty">
					 <dsp:param param="element" name="value"/>
					 <dsp:oparam name="false">
						<dsp:getvalueof var="media" param="element"/>  
							<dsp:include page="/new_comvita/pages/global/renderLocaleAwareMedia.jsp" flush="true" >
								<dsp:param name="mediaForLocale" value="${media}" />
							</dsp:include>
					 </dsp:oparam>
				   </dsp:droplet>   
				 </dsp:oparam>   
			</dsp:droplet>
		</c:when>
		<c:otherwise>
	      <script src="https://maps.google.com.hk/maps/api/js?key=AIzaSyCi9rSvBuEiABFgYL_rBDNcrsFglTvVxOs&language=zh-TW&region=hk&callback=initMap"></script>
	      <div id="wrapper" class="border-t-8-lightgrey">
	         <%-- Sidebar --%>
	         <div id="sidebar-wrapper">
	            <c:set var="lbl_storelocator_sidebar_heading_placeholder">
	               <sgsl:label key="lbl_storelocator_sidebar_heading_placeholder" language="${language}"></sgsl:label>
	            </c:set>
	            <c:set var="lbl_storelocator_sidebar_heading_title">
	               <sgsl:label key="lbl_storelocator_sidebar_heading_title" language="${language}"></sgsl:label>
	            </c:set>
	            <h1 >
	               <sgsl:label key="lbl_storelocator_sidebar_heading" language="${pageContext.request.locale.language}" />
	            </h1>
	            <input type="text" id="myInput" onkeyup="myFunction()" placeholder="${lbl_storelocator_sidebar_heading_placeholder}" title="${lbl_storelocator_sidebar_heading_title}">
	            <ul class="sidebar-nav" id="side_bar">
	            </ul>
	         </div>
	         <div id="page-content-wrapper">
	            <div class="container-fluid">
	               <div class="row">
	                  <div class="col-lg-12">
	                     <dsp:droplet
	                        name="/com/sgs/commerce/browse/droplet/StoresDroplet">
	                        <dsp:param name="siteId" value="${appid}" />
	                        <dsp:oparam name="output">
	                           <dsp:getvalueof var="totalSize" param="totalSize"></dsp:getvalueof>
	                           <dsp:getvalueof var="storesList" param="storesList"></dsp:getvalueof>
	                           <dsp:getvalueof var="storeCityNameMap" param="StoreCityAndName"></dsp:getvalueof>
	                           <dsp:getvalueof var="listOfCategoryNamesOfAllStores" param="listOfCategoryNamesOfAllStores"></dsp:getvalueof>
	                           <dsp:getvalueof var="mapOfStoreCategoryNamesAndAssociatedStores" param="sortedMapOfStoreCategoryNamesAndAssociatedStores"></dsp:getvalueof>
	                        </dsp:oparam>
	                     </dsp:droplet>
	                     <c:forEach items="${listOfCategoryNamesOfAllStores}" var="categoryNameOfStore" varStatus="counter">
	                    	<c:set var="newStoresList" value="${mapOfStoreCategoryNamesAndAssociatedStores[categoryNameOfStore.storeLocatorCategoryName]}"/>
	                    	<%-- <c:if test="${fn:length(newStoresList)> 0}">
								${keyName}-----
							</c:if> --%>
	                     
						 	 <c:forEach items="${newStoresList}" var="store" varStatus="count">		
		                       <span category="${categoryNameOfStore.storeLocatorCategoryName}" class="StoreDataFromBcc" locationId = "${store.locationId}" locationName = "${store.locationName}" addressLine1="${store.addressLine1}" addressLine3="${store.addressLine3}"  addressLine2= "${store.addressLine2}" city = "${store.city}" state = "${store.state}" postalCode = "${store.postalCode}" countryCode = "${store.countryCode}" hours = "${store.hours}" longitude= "${store.longitude}" latitude = "${store.latitude}" phone="${store.phone}"></span>
		                     </c:forEach> 
						
	                    	
	                     </c:forEach>
	                    <%--  <c:forEach items="${storesList}" var="store" varStatus="count">		
	                       <span class="StoreDataFromBcc" locationId = "${store.locationId}" locationName = "${store.locationName}-${store.storeLocatorCategoryName}" addressLine1="${store.addressLine1}" addressLine3="${store.addressLine3}"  addressLine2= "${store.addressLine2}" city = "${store.city}" state = "${store.state}" postalCode = "${store.postalCode}" countryCode = "${store.countryCode}" hours = "${store.hours}" longitude= "${store.longitude}" latitude = "${store.latitude}" phone="${store.phone}"></span>
	                     </c:forEach> --%>
	                     <h1 class="m-t-10 p-b-20">
	                        <a href="#menu-toggle" class="gradient-menu" id="menu-toggle"></a>
	                        <sgsl:label key="lbl_store_locator_heading" language="${pageContext.request.locale.language}" />
	                     </h1>
	                     <%-- you can use tables or divs for the overall layout --%>
	                     <div id="map_canvas"></div>
	                     <br/>
	                     <br/>
	                     <br/>
	                  </div>
	               </div>
	            </div>
	         </div>
	      </div>
	      <input id ="DynValSL"type="hidden" call = '<sgsl:label key="lbl_storelocator_popup_call" language="${language}"></sgsl:label>' 
	      getDirection='<sgsl:label key="lbl_storelocator_popup_get_direction" language="${language}"></sgsl:label>' 
	      businessHour='<sgsl:label key="lbl_storelocator_popup_business_hour" language="${language}"></sgsl:label>' />
	   </c:otherwise>
      </c:choose>
   </tek:main-layout>
</dsp:page>
