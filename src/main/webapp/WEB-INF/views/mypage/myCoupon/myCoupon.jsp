<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set
        var="signInOut"
        value="${sessionScope.memberResponse==null ? '로그인' : '로그아웃'}"
/>
<c:set
        var="signInOutLink"
        value="${sessionScope.memberResponse==null ? '/members' : '/members/signout'}"
/>
<c:set
        var="name"
        value="${sessionScope.memberResponse==null ? '회원가입' : sessionScope.memberResponse.user_nm}"
/>
<c:set
        var="nameLink"
        value="${sessionScope.memberResponse==null ? '/members/signup' : '/mypage/coupon'}"
/>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여기에 상품 제목 들어가유 c 태그로 잘 넣어주세용</title>
    <link rel="stylesheet" type="text/css" href="/mypage/myCoupon/reset.css">
    <link rel="stylesheet" type="text/css" href="/mypage/myCoupon/navigation.css">
    <link rel="stylesheet" type="text/css" href="/mypage/myCoupon/mypage.css">
    <link rel="stylesheet" type="text/css" href="/mypage/myCoupon/myCoupon.css">
    <style>
        #whole_container {
            width: 100%;
            height: 100vh;
        }

        button {
            width: 200px;
            height: 100px;
        }

        #content {
            display: flex;
            padding: 30px 200px 160px 200px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>

<body>
<div id="whole_container">
    <div id="navigation">
        <div id="signup_signin_container">
            <div id="signup_signin">
                <a id="signup" href="${nameLink}">${name}</a>
                <div></div>
                <a id="signin" href="${signInOutLink}">${signInOut}</a>
                <div></div>
                <a id="cust">고객센터</a>
            </div>
        </div>
        <div id="search">
            <div id="search_first">
                <img style="width:82px; height: 42px" src="/mypage/myCoupon/imgs/logo.png" alt="logo"/>
                <a>마켓컬리</a>
                <div></div>
                <a>뷰티컬리</a>
            </div>
            <div id="input_container">
                <input placeholder="검색어를 입력해주세요"/>
                <img src="/mypage/myCoupon/imgs/loupe.png" style="width: 20px; height: 20px"/>
            </div>
            <div id="icon_container">
                <img src="/mypage/myCoupon/imgs/location.png"/>
                <img src="/mypage/myCoupon/imgs/heart.png"/>
                <img src="/mypage/myCoupon/imgs/shopping-cart.png"/>
            </div>
        </div>
        <div id="menubar">
            <div id="category_container">
                <img src=""/>
                <span>카테고리</span>
            </div>
            <div id="menus">
                <span><a href="">신상품</a></span>
                <span><a href="">베스트</a></span>
                <span><a href="">알뜰쇼핑</a></span>
                <span><a href="/event/main">특가/혜택</a></span>
            </div>
            <div id="deli_info">
                <span id="purple_deli_info">샛별·낮</span>
                <span id="gray_deli_info">배송안내</span>
            </div>
        </div>
    </div>
    <div id="content">
        <div id="my_kurly">
            <h2>마이컬리</h2>
            <ul>
                <a href="">
                    <li>주문 내역</li>
                </a>
                <a href="">
                    <li>선물 내역</li>
                </a>
                <a href="">
                    <li>찜한 상품</li>
                </a>
                <a href="">
                    <li>배송지 관리</li>
                </a>
                <a href="">
                    <li>상품 후기</li>
                </a>
                <a href="">
                    <li>상품 문의</li>
                </a>
                <a href="">
                    <li>적립금</li>
                </a>
                <a href="">
                    <li>쿠폰</li>
                </a>
                <a href="">
                    <li>개인 정보 수정</li>
                </a>
            </ul>
        </div>
        <div id="mypage_content">
            <h3>쿠폰</h3>
            <div id="add_coupon_box">
                <form id="coupon_form" onsubmit="return false;">
                    <div id="add_input_wrapper">
                        <input id="coupn_to_add" type="text" placeholder="발급된 쿠폰번호를 입력해 주세요">
                    </div>
                    <button id="add_coupon_button" onclick="addCoupon()">
                        쿠폰 등록
                    </button>
                </form>
            </div>
            <div id="optional_function">

            </div>
            <div id="mypage_content_body">
                <div class="cols">
                    <div class="first_col col">쿠폰명</div>
                    <div class="second_col col">기능</div>
                    <div class="third_col col">할인/적립</div>
                    <div class="fourth_col col">사용가능기간</div>
                    <div class="fifth_col col">사용여부</div>
                </div>
                <div id="coupons">
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let dateParse = function (str) {
        let y = str.substring(0, 4),
            m = str.substring(4, 6),
            d = str.substring(6, 8);
        return y + "년 " + m + "월 " + d + "일";
    }

    let isExpired = function (str) {
        let y = str.substring(0, 4),
            m = str.substring(4, 2),
            d = str.substring(6, 2);

        return new Date(y, m, d) < new Date(0);
    }

    let toHtml = function (res) {
        let tmp = '';

        res.forEach(el => {
            console.log(el.used);
            tmp += '<div class="coupon cols">' +
                '<div class="coupon_name first_col"> <h4>' +
                el.nm + '</h4><p>최대 ' +
                el.ds_max_posbl_amt.toLocaleString() +
                '원 할인</p> <p>' +
                (el.lmtt_cnd == null ? "" : el.lmtt_cnd) +
                '</p> </div><div class="coupon_func second_col col">' +
                el.func + '</div><div class="coupon_rate third_col col">' +
                el.rate + '%</div><div class="coupon_due fourth_col col">' +
                dateParse(el.expi_dd) +
                '까지</div><div class="coupon_used fifth_col col">' +
                (el.used ? "사용" : "미사용") +
                '</div></div>';
        })

        return tmp;
    }

    $(document).ready(
        $.ajax({
            type: 'GET',       // 요청 메서드
            url: '/mypage/coupon',  // 요청 URI
            success: function (result) {
                $("#optional_function").html(`사용 가능 쿠폰 \${result.length} 장`);
                $("#coupons").html(toHtml(result));
            },
            error: function (result) {
                alert("쿠폰 불러오기 실패");
            } // 에러가 발생했을 때, 호출될 함수
        })
    )

    let addCoupon = function () {
        let nm = encodeURI($("#coupn_to_add").val());

        if (nm !== "") {
            $.ajax({
                type: 'POST',       // 요청 메서드
                url: '/mypage/coupon?nm=' + nm,  // 요청 URI
                success: function (res) {
                    window.location.reload();
                },
                error: function (res) {
                    if (res.status === 400) {
                        alert("쿠폰 이름을 잘못 입력하였습니다")
                    } else {
                        alert("서버에 문제가 있습니다");
                    }
                } // 에러가 발생했을 때, 호출될 함수
            })
        } else {
            alert("등록할 쿠폰의 이름을 넣어주세요!");
        }
    }
</script>
</body>
</html>