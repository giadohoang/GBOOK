<%@taglib uri="/WEB-INF/tlds/custom.tld" prefix="dates" %>
<!DOCTYPE html>
<html>

<jsp:include page="/WEB-INF/head_tag.jsp">
    <jsp:param name="title" value="Your Profile"/>
</jsp:include>

<body>
    <%@include file="/WEB-INF/top_nav.jspf" %>

    <section class="container-fluid" id="main-body">
        <div class="row no-pad">
            <div class="col-md-8 no-pad">
                <div class="profile-header">
                    <div class="profile-header-top">
                        <span id="profile-button-add-cover">
                                <form action="UploadImage" id="frmUploadPhoto" 
                                      enctype="multipart/form-data" method="post" >
                                    <i class="fa fa-camera" aria-hidden="true"></i>
                                    Add Cover Photo
                                    <input class="input-cover-photo" type="file" 
                                           id="userCoverPhoto" name="userCoverPhoto"/>
                                </form>
                            </span>
                        <img src="${pageContext.servletContext.contextPath}/ProcessImage?emailOrPhone=${sessionScope.user.emailOrPhone}">
                        <h3>
                            ${sessionScope.user.firstName}
                            ${sessionScope.user.lastName}
                            
                        </h3>
                        <a href="" id="profile-button-update-info">Update Info <span>1</span></a>
                        <a href="" id="profile-button-view-log">View Activity Log <span>5</span></a>
                    </div>
                    <ul class="profile-header-nav">
                        <li></li>
                        <li><a href="/">Timeline</a></li>
                        <li><a href="/">About</a></li>
                        <li><a href="/">Friends</a></li>
                        <li><a href="/">Photos</a></li>
                        <li><a href="/">More <i class="fa fa-caret-down" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="profile-body">
                    <div class="profile-body-header">
                        <h3><i class="fa fa-user" aria-hidden="true"></i> About</h3>
                    </div>
                    <div class="profile-body-content">
                        <div class="row no-pad">
                            <div class="col-md-4 profile-body-content-tool no-pad">
                                <a href="/" class="active">Overview</a>
                                <a href="/">Work and education</a>
                                <a href="/">Places you've lived</a>
                                <a href="/">Contact information</a>
                                <a href="/">Family and relationship</a>
                                <a href="/">Detailed about you</a>
                                <a href="/">Life events</a>
                            </div>
                            <div class="col-md-8 profile-body-content-editing">
                                <h4>Overview</h4>
                                <div class="overview-form">
                                    <div class="alert-danger">
                                        ${sessionScope.error}
                                    </div>
                                  <form action="ProcessProfile" method="post">
                                          <label>First Name:</label>
                                          <input required type="text" name="first-name" maxlength="30" 
                                                 value="${sessionScope.user.firstName}"
                                          />

                                          <label>Last Name:</label>
                                          <input required type="text" name="last-name" maxlength="30" 
                                                 value="${sessionScope.user.lastName}"/>

                                          <label>Email/Mobile:</label>
                                          <input required type="email" name="mobile-or-email" 
                                                 value="${sessionScope.user.emailOrPhone}"/>

                                          <label>Password:</label>
                                          <input required type="password" name="user-password" />

                                          <label>Sex:</label>
                                          <input checked type="radio" name="sex" id="male"> <label class="light" for="male">Male</label>
                                          <input type="radio" name="sex" id="female"> <label class="light" for="female">Female</label>

                                          <label style="display:block;">Birthday</label>
                                          <div class="reg-input">
                                              <select name="day" id="days">
                                                  <option>Day</option>
                                              </select>
                                              <select name="month" id="months">
                                                  <option>Month</option>
                                              </select>
                                              <select name="year" id="years">
                                                  <option>Year</option>
                                              </select>
                                          </div>

                                          <button name="action" value ="update-profile" type="submit">Save Changes</button>
                                      </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="middle-right-ads">
                    <h4>Sponsored</h4>
                    <div class="ads-item">
                        <img src="img/ad1.jpg">
                        <a href="">ABC Banking</a>
                        <p>
                            ACB PRIVILEGE BANKING – TRỌN VẸN ĐẲNG CẤP Đồng hành cùng đẳng cấp và vị thế của bạn, phải...
                        </p>
                    </div>
                    <div class="ads-item">
                        <img src="img/ad2.jpg">
                        <a href="">ABC Banking</a>
                        <p>
                            ACB PRIVILEGE BANKING – TRỌN VẸN ĐẲNG CẤP Đồng hành cùng đẳng cấp và vị thế của bạn, phải...
                        </p>
                    </div>
                    <div class="ads-item">
                        <img src="img/ad3.png">
                        <a href="">ABC Banking</a>
                        <p>
                            ACB PRIVILEGE BANKING – TRỌN VẸN ĐẲNG CẤP Đồng hành cùng đẳng cấp và vị thế của bạn, phải...
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 no-pad">
                <%@include file="/WEB-INF/friend-list.jspf"%>
            </div>
        </div>
    </section>
    <script>
        $(function() {
           
            
            $('#userCoverPhoto').change(function(){
               $('#frmUploadPhoto').submit(); 
            });
            
            
            
            var day = "${dates:getDatePart(sessionScope.user.birthday)[0]}";
            var month = "${dates:getDatePart(sessionScope.user.birthday)[1]}";
            var year = "${dates:getDatePart(sessionScope.user.birthday)[2]}";

            for (var i = 1; i <= 31; i++) {
                if(i == day){
                    $("#days").append("<option selected>" + i + "</option>");    
                } else {
                     $("#days").append("<option>" + i + "</option>");  
                }
                 
            }
            
            for (var i = 1; i <= 12; i++) {
                if(i == month){
                     $("#months").append("<option selected>" + i + "</option>");   
                }
                else{
                     $("#months").append("<option>" + i + "</option>");   
                }
                
            }
            
            for (var i = 2016; i >= 1905; i--) {
                if(i == year){
                    $("#years").append("<option selected>" + i + "</option>");
                }
                else{
                    $("#years").append("<option>" + i + "</option>");    
                }
                    
            }
            
            var selectedSex = "${sessionScope.user.sex}";
            $("input[name=sex][value=" + selectedSex + "]").prop('checked', true);
            var viewportHeight = $(window).height();
            $("#online-list").css("max-height", viewportHeight);
        });
    </script>
    <script src="js/app.js"></script>
</body>

</html>
