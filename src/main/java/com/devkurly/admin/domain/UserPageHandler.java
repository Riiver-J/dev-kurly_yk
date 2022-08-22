package com.devkurly.admin.domain;

import org.springframework.web.util.*;

public class UserPageHandler {
//    private int page;
//    private int pageSize;
//    private String option;
//    private String keyword;
    private UserSearchCondition sc;
    private int totalCnt;
    private int naviSize = 10;
    private int totalPage;
    private int beginPage;
    private int endPage;
    private boolean showPrev;
    private boolean showNext;

    public UserPageHandler(int totalCnt, UserSearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;
    }

    public void dopaging(int totalCnt, UserSearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;

        dopaging(totalCnt, sc);
    }

    public void doPaging(int totalCnt, UserSearchCondition sc) {
        this.totalCnt = totalCnt;

        totalPage = (int)Math.ceil((totalCnt) / (double)sc.getPageSize());
        beginPage = (sc.getPage()-1) / naviSize * naviSize + 1;
        endPage = Math.min(beginPage + naviSize-1, totalPage);
        showPrev = beginPage != 1;
        showNext = endPage != totalPage;
    }

    void print() {                              //ln빼야되지않나?
        System.out.println("page = " + sc.getPage());
        System.out.print(showPrev ? "[PREV] " : "");
        for (int i = beginPage; i <= endPage ; i++) {
            System.out.print(i+" ");
        }
        System.out.println(showNext ? " [NEXT]" : "");
    }


    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public int getNaviSize() {
        return naviSize;
    }

    public void setNaviSize(int naviSize) {
        this.naviSize = naviSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    @Override
    public String toString() {
        return "UserPageHandler{" +
                "sc=" + sc +
                ", totalCnt=" + totalCnt +
                ", naviSize=" + naviSize +
                ", totalPage=" + totalPage +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                '}';
    }
}
