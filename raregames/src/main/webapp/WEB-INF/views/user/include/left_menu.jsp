<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>${loginUser.userNm }</p>
          <!-- Status -->
          <c:if test="${sessionScope.loginUser != null }">
          	<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
          </c:if>
           <c:if test="${sessionScope.loginUser == null }">
          	<a href="#"><i class="fa fa-circle" style="color:red;"></i> Offline</a>
          </c:if>
        </div>
      </div>

      <!-- search form (Optional) -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
              </button>
            </span>
        </div>
      </form>
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">HEADER</li>
        <!-- Optionally, you can add icons to the links -->
        <li class="active"><a href="/"><i class="fa fa-link"></i> <span>RareGames</span></a></li>
        <li class="treeview">
          <a href="#"><i class="fa fa-archive"></i> <span>상품관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/user/prod/list">상품 목록</a></li>
            <li><a href="/user/prod/insert">상품 등록</a></li>
          </ul>
        </li>
         <li class="treeview">
          <a href=""><i class="fa fa-truck"></i> <span>구매관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/user/purchse/list">구매정보</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-user"></i> <span>회원관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/user/mber/list">회원목록</a></li>
          </ul>
        </li>
         <li class="treeview">
          <a href="#"><i class="fa fa-bar-chart"></i> <span>통계관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/user/chart/overall">구매통계</a></li>
          </ul>
        </li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
