<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>비밀번호 변경</title>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
        font-family: "Pretendard", "Noto Sans KR", Arial, sans-serif;
        color: #1e293b;
        background:
            radial-gradient(circle at 10% 10%, #dbeafe 0, transparent 32%),
            linear-gradient(135deg, #f8fbff 0%, #eaf3ff 100%);
    }

    .password-card {
        width: 100%;
        max-width: 430px;
        padding: 42px 38px;
        border: 1px solid rgba(147, 197, 253, 0.45);
        border-radius: 20px;
        background: rgba(255, 255, 255, 0.94);
        box-shadow: 0 20px 50px rgba(37, 99, 235, 0.13);
    }

    .icon {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 58px;
        height: 58px;
        margin: 0 auto 20px;
        border-radius: 16px;
        color: #ffffff;
        font-size: 27px;
        background: linear-gradient(135deg, #2563eb, #60a5fa);
        box-shadow: 0 10px 22px rgba(37, 99, 235, 0.25);
    }

    h2 {
        margin-bottom: 10px;
        text-align: center;
        color: #172554;
        font-size: 25px;
    }

    .description {
        margin-bottom: 30px;
        text-align: center;
        color: #64748b;
        font-size: 14px;
        line-height: 1.6;
    }

    .input-group {
        margin-bottom: 20px;
    }

    .input-group label {
        display: block;
        margin-bottom: 8px;
        color: #334155;
        font-size: 14px;
        font-weight: 600;
    }

    .password-input {
        position: relative;
    }

    .password-input input {
        width: 100%;
        height: 49px;
        padding: 0 48px 0 14px;
        border: 1px solid #cbd5e1;
        border-radius: 10px;
        outline: none;
        color: #1e293b;
        font-size: 15px;
        background: #f8fafc;
        transition: 0.2s;
    }

    .password-input input:focus {
        border-color: #3b82f6;
        background: #ffffff;
        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.12);
    }

    .toggle-button {
        position: absolute;
        top: 50%;
        right: 14px;
        border: none;
        color: #64748b;
        font-size: 18px;
        cursor: pointer;
        background: transparent;
        transform: translateY(-50%);
    }

    .error-message {
        margin: -6px 0 18px;
        color: #dc2626;
        font-size: 13px;
        text-align: center;
    }

    .submit-button {
        width: 100%;
        height: 51px;
        margin-top: 5px;
        border: none;
        border-radius: 10px;
        color: #ffffff;
        font-size: 16px;
        font-weight: 700;
        cursor: pointer;
        background: linear-gradient(135deg, #2563eb, #3b82f6);
        box-shadow: 0 9px 20px rgba(37, 99, 235, 0.24);
        transition: 0.2s;
    }

    .submit-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 25px rgba(37, 99, 235, 0.32);
    }

    .submit-button:active {
        transform: translateY(0);
    }

    @media (max-width: 480px) {
        .password-card {
            padding: 34px 24px;
        }
    }
</style>
</head>

<body>

<div class="password-card">

    <div class="icon">🔒</div>

    <h2>비밀번호 변경</h2>

    <p class="description">
        최초 로그인입니다.<br>
        안전한 서비스 이용을 위해 새 비밀번호를 설정해주세요.
    </p>

    <form action="${pageContext.request.contextPath}/change-password"
          method="post"
          onsubmit="return validatePassword();">

        <%-- Spring Security에서 CSRF를 사용하는 경우 필요합니다. --%>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}">

        <div class="input-group">
            <label for="newPassword">새 비밀번호</label>

            <div class="password-input">
                <input type="password"
                       id="newPassword"
                       name="newPassword"
                       placeholder="새 비밀번호를 입력해주세요"
                       autocomplete="new-password"
                       required>

                <button type="button"
                        class="toggle-button"
                        onclick="togglePassword('newPassword', this)"
                        aria-label="비밀번호 표시">
                    ◉
                </button>
            </div>
        </div>

        <div class="input-group">
            <label for="confirmPassword">새 비밀번호 확인</label>

            <div class="password-input">
                <input type="password"
                       id="confirmPassword"
                       name="confirmPassword"
                       placeholder="새 비밀번호를 다시 입력해주세요"
                       autocomplete="new-password"
                       required>

                <button type="button"
                        class="toggle-button"
                        onclick="togglePassword('confirmPassword', this)"
                        aria-label="비밀번호 표시">
                    ◉
                </button>
            </div>
        </div>

        <p id="errorMessage" class="error-message">
            ${errorMessage}
        </p>

        <button type="submit" class="submit-button">
            비밀번호 변경하기
        </button>

    </form>
</div>

<script>
    function togglePassword(inputId, button) {
        const input = document.getElementById(inputId);

        if (input.type === "password") {
            input.type = "text";
            button.textContent = "○";
            button.setAttribute("aria-label", "비밀번호 숨기기");
        } else {
            input.type = "password";
            button.textContent = "◉";
            button.setAttribute("aria-label", "비밀번호 표시");
        }
    }

    function validatePassword() {
        const newPassword =
            document.getElementById("newPassword").value;

        const confirmPassword =
            document.getElementById("confirmPassword").value;

        const errorMessage =
            document.getElementById("errorMessage");

        if (newPassword !== confirmPassword) {
            errorMessage.textContent =
                "새 비밀번호가 서로 일치하지 않습니다.";

            return false;
        }

        errorMessage.textContent = "";
        return true;
    }
</script>

</body>
</html>