<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
body {
  margin: 0;
  color: #6a6f8c;
  background: #c8c8c8;
  font: 600 16px/18px 'Open Sans', sans-serif;
}
*, :after, :before { box-sizing: border-box; }
.clearfix:after, .clearfix:before { content: ''; display: table; }
.clearfix:after { clear: both; display: block; }
a { color: inherit; text-decoration: none; }
.login-wrap {
  width: 100%;
  margin: auto;
  max-width: 525px;
  min-height: 670px;
  position: relative;
  background: url(https://raw.githubusercontent.com/khadkamhn/day-01-login-form/master/img/bg.jpg) no-repeat center;
  box-shadow: 0 12px 15px 0 rgba(0,0,0,.24), 0 17px 50px 0 rgba(0,0,0,.19);
}
.login-html {
  width: 100%;
  height: 100%;
  position: absolute;
  padding: 90px 70px 50px 70px;
  background: rgba(40,57,101,.9);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm {
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  position: absolute;
  transform: rotateY(180deg);
  backface-visibility: hidden;
  transition: all .4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check {
  display: none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .button {
  text-transform: uppercase;
}
.login-html .tab {
  font-size: 22px;
  margin: 0 15px 10px 0;
  padding-bottom: 5px;
  display: inline-block;
  border-bottom: 2px solid transparent;
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab {
  color: #fff;
  border-color: #1161ee;
}
.login-form {
  min-height: 345px;
  position: relative;
  perspective: 1000px;
  transform-style: preserve-3d;
}
.login-form .group {
  margin-bottom: 15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .button {
  width: 100%;
  color: #fff;
  display: block;
}
.login-form .group .input,
.login-form .group .button {
  border: none;
  padding: 15px 20px;
  border-radius: 25px;
  background: rgba(255,255,255,.1);
}
.login-form .group input[data-type="password"] {
  text-security: circle;
  -webkit-text-security: circle;
}
.login-form .group .label {
  color: #aaa;
  font-size: 12px;
}
.login-form .group .button {
  background: #1161ee;
}
.login-html .sign-in:checked ~ .login-form .sign-in-htm {
  transform: rotate(0);
}
.login-html .sign-up:checked ~ .login-form .sign-up-htm {
  transform: rotate(0);
}
.hr {
  height: 2px;
  margin: 60px 0 50px 0;
  background: rgba(255,255,255,.2);
}
.foot-lnk {
  text-align: center;
}
</style>

<div class="login-wrap">
  <div class="login-html">
    <input id="tab-1" type="radio" name="tab" class="sign-in" checked>
    <label for="tab-1" class="tab">Sign In</label>
    <input id="tab-2" type="radio" name="tab" class="sign-up">
    <label for="tab-2" class="tab">Sign Up</label>

    <div class="login-form">

      <!-- 로그인 폼 -->
      <form action="loginProc.jsp" method="post" class="sign-in-htm">
        <div class="group">
          <label for="login-user" class="label">UserId</label>
          <input id="login-user" name="userId" type="text" class="input">
        </div>
        <div class="group">
          <label for="login-pass" class="label">Password</label>
          <input id="login-pass" name="password" type="password" class="input" data-type="password">
        </div>
        <div class="group">
          <input id="check" type="checkbox" class="check" checked>
          <label for="check"><span class="icon"></span> Keep me Signed in</label>
        </div>
        <div class="group">
          <input type="submit" class="button" value="Sign In">
        </div>
        <div class="hr"></div>
        <div class="foot-lnk">
          <a href="#forgot">Forgot Password?</a>
        </div>
      </form>

      <!-- 회원가입 폼 -->
      <form action="signUpProc.jsp" method="post" class="sign-up-htm">
        <div class="group">
          <label for="signup-user" class="label">UserId</label>
          <input id="signup-user" name="userId" type="text" class="input">
        </div>
        <div class="group">
          <label for="signup-pass" class="label">Password</label>
          <input id="signup-pass" name="password" type="password" class="input" data-type="password">
        </div>
        <div class="group">
          <label for="signup-pass-repeat" class="label">Repeat Password</label>
          <input id="signup-pass-repeat" name="passwordRepeat" type="password" class="input" data-type="password">
        </div>
        <div class="group">
          <label for="signup-name" class="label">Name</label>
          <input id="signup-name" name="userName" type="text" class="input">
        </div>
        <div class="group">
          <label for="signup-email" class="label">Email Address</label>
          <input id="signup-email" name="email" type="text" class="input">
        </div>
        <div class="group">
          <input type="submit" class="button" value="Sign Up">
        </div>
        <div class="hr"></div>
        <div class="foot-lnk">
          <label for="tab-1">Already Member?</label>
        </div>
      </form>

    </div>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
  // 회원가입 버튼 클릭 시
  $(".sign-up-htm").on("submit", function (e) {
    e.preventDefault(); // 기본 제출 막기

    const userId = $("#signup-user").val().trim();

    if (!userId) {
      alert("아이디를 입력해주세요.");
      $("#signup-user").focus();
      return;
    }

    // AJAX 중복 검사
    $.ajax({
      url: "/user/userIdCheckAjax.jsp", // 경로는 환경에 맞게 조정
      type: "POST",
      data: { userId: userId },
      dataType: "json",
      success: function (res) {
        if (res.flag === 0) {
          // 중복 없음 → 폼 제출
          e.target.submit();
        } else if (res.flag === 1) {
          alert("이미 존재하는 아이디입니다.");
          $("#signup-user").focus();
        } else {
          alert("아이디 중복 검사 오류입니다.");
        }
      },
      error: function () {
        alert("서버 요청 실패");
      }
    });
  });
});
</script>