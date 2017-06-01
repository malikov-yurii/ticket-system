<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>

<head>
    <jsp:include page="fragments/headTag.jsp"/>
</head>

<body class="flights">
<jsp:include page="fragments/bodyHeader.jsp"/>

<div class="jumbotron">
    <div class="container">
        <div class="shadow">
            <h3 class="page-title"><fmt:message key="app.flights"/></h3>


            <div class="view-box">
                <div class="row">
                    <div class="col-sm-7">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <form:form class="form-horizontal" id="filter">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3"
                                               for="departureAirportCondition"><spring:message
                                                code="airport.departure"/>:</label>
                                        <div class="col-sm-3">
                                            <input class="input-filter form-control input-airport valid"
                                                   name="departureAirportCondition" id="departureAirportCondition">
                                        </div>

                                        <label class="control-label col-sm-4"
                                               for="arrivalAirportCondition"><spring:message
                                                code="airport.arrival"/>:</label>

                                        <div class="col-sm-2">
                                            <input class="input-filter form-control input-airport valid"
                                                   name="arrivalAirportCondition" id="arrivalAirportCondition">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="fromDepartureDateTimeCondition">
                                            <spring:message code="flight.fromDepartureDateTime"/>:</label>
                                        <div class="col-sm-3">
                                            <input class="input-filter form-control input-datetime active-input"
                                                   name="fromDepartureDateTimeCondition"
                                                   id="fromDepartureDateTimeCondition">
                                        </div>

                                        <label class="control-label col-sm-4" for="toDepartureDateTimeCondition">
                                            <spring:message code="flight.toDepartureDateTime"/>:</label>
                                        <div class="col-sm-2">
                                            <input class="input-filter form-control input-datetime departure-datetime active-input"
                                                   name="toDepartureDateTimeCondition"
                                                   id="toDepartureDateTimeCondition">
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                            <div class="panel-footer text-right">
                                <sec:authorize access="hasRole('ROLE_ADMIN')">
                                    <a class="btn btn-danger" type="button" onclick="clearFilter()">
                                        <span aria-hidden="true">Clean Filter</span>
                                    </a>
                                </sec:authorize>

                                <a class="btn btn-primary" type="button" onclick="showOrUpdateTable(false, false)">
                                    <%--<span class="glyphicon glyphicon-filter" aria-hidden="true"></span>--%>
                                    <span aria-hidden="true">Search</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="view-box datatable" hidden="true">

                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <a class="btn btn-sm btn-info show-add-new-modal" onclick="showAddModal()">
                        <fmt:message key="flight.addNewFlight"/></a>
                </sec:authorize>


                <table class="table table-striped display" id="datatable">
                    <thead>
                    <tr>
                        <th><fmt:message key="app.id"/></th>
                        <th><fmt:message key="airport.departure"/></th>
                        <th><fmt:message key="airport.arrival"/></th>
                        <th><fmt:message key="flight.departureLocalDateTime"/></th>
                        <th><fmt:message key="flight.arrivalLocalDateTime"/></th>
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <th><fmt:message key="aircraft.name"/></th>
                            <th><fmt:message key="flight.initialTicketBasePrice"/></th>
                            <th><fmt:message key="flight.maxTicketBasePrice"/></th>
                            <th></th>
                            <th></th>
                        </sec:authorize>
                        <sec:authorize access="!hasRole('ROLE_ADMIN')">
                            <th><fmt:message key="flight.ticketPrice"/></th>
                        </sec:authorize>
                        <sec:authorize access="!hasRole('ROLE_ADMIN')  && hasRole('ROLE_USER')">
                            <th></th>
                        </sec:authorize>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editRow">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <%--todo class and id???--%>
                <h2 class="modal-title" id="modalTitle"></h2>
            </div>
            <div class="modal-body">
                <form:form class="form-horizontal" method="post" id="detailsForm">

                    <div class="seat-picker__title">
                        Please, select your seat
                    </div>
                    <div class="seat-picker"></div>


                    <input type="text" hidden="hidden" id="id" name="id">

                    <div class="form-group">
                        <label for="departureAirport" class="control-label col-xs-3"><fmt:message
                                key="airport.departure"/></label>

                        <div class="col-xs-9">
                            <input type="text" class="modal-input form-control input-airport" id="departureAirport"
                                   name="departureAirport"
                                   placeholder="please choose arrival airport from drop down list">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="arrivalAirport" class="control-label col-xs-3"><fmt:message
                                key="airport.arrival"/></label>

                        <div class="col-xs-9">
                            <input type="text" class="modal-input form-control input-airport" id="arrivalAirport"
                                   name="arrivalAirport"
                                   placeholder="please choose arrival airport from drop down list">
                        </div>
                    </div>


                    <sec:authorize access="!hasRole('ROLE_ADMIN')  && hasRole('ROLE_USER')">

                        <div class="form-group">
                            <label for="departureCity" class="control-label col-xs-3"><fmt:message
                                    key="city.departure"/></label>

                            <div class="col-xs-9">
                                <input type="text" class="modal-input form-control input-city" id="departureCity"
                                       name="departureCity" readonly="readonly">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="arrivalCity" class="control-label col-xs-3"><fmt:message
                                    key="city.arrival"/></label>

                            <div class="col-xs-9">
                                <input type="text" class="modal-input form-control input-city" id="arrivalCity"
                                       name="arrivalCity" readonly="readonly">
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="price" class="control-label col-xs-3"><fmt:message
                                    key="flight.ticketPrice"/></label>

                            <div class="col-xs-9">
                                <input type="text" class="modal-input form-control " id="price"
                                       name="price" readonly="readonly" value="<%=session.getAttribute("price")%>">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="seatNumber" class="control-label col-xs-3"><fmt:message
                                    key="ticket.seatNumber"/></label>

                            <div class="col-xs-9">
                                <input type="text" class="modal-input form-control " id="seatNumber"
                                       name="seatNumber" readonly="readonly">
                            </div>
                        </div>
                    </sec:authorize>


                    <div class="form-group">
                        <label for="departureLocalDateTime" class="control-label col-xs-3"><fmt:message
                                key="flight.departureLocalDateTime"/></label>

                        <div class="col-xs-9">
                            <input type="text" class="modal-input form-control input-datetime active-input"
                                   id="departureLocalDateTime"
                                   name="departureLocalDateTime"
                                   placeholder="please set arrival local date">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="arrivalLocalDateTime" class="control-label col-xs-3"><fmt:message
                                key="flight.arrivalLocalDateTime"/></label>

                        <div class="col-xs-9">
                            <input type="text" class="modal-input form-control input-datetime active-input"
                                   id="arrivalLocalDateTime"
                                   name="arrivalLocalDateTime"
                                   placeholder="please set arrival local date">
                        </div>
                    </div>

                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <div class="form-group">
                            <label for="aircraftName" class="control-label col-xs-3"><fmt:message
                                    key="aircraft.name"/></label>

                            <div class="col-xs-9">
                                <input type="text" class="modal-input form-control input-aircraft" id="aircraftName"
                                       name="aircraftName"
                                       placeholder="please choose aircraft from drop down list">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="initialBaseTicketPrice" class="control-label col-xs-3"><fmt:message
                                    key="flight.initialTicketBasePrice"/></label>

                            <div class="col-xs-9">
                                <input type="number" class="modal-input form-control" id="initialBaseTicketPrice"
                                       name="initialBaseTicketPrice" placeholder="10.00">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="maxBaseTicketPrice" class="control-label col-xs-3"><fmt:message
                                    key="flight.maxTicketBasePrice"/></label>

                            <div class="col-xs-9">
                                <input type="number" class="modal-input form-control" id="maxBaseTicketPrice"
                                       name="maxBaseTicketPrice" placeholder="20.00">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-offset-3 col-xs-9">
                                <button class="btn btn-primary" type="button" onclick="saveFlight()"><fmt:message
                                        key="common.save"/></button>
                            </div>
                        </div>
                    </sec:authorize>

                    <sec:authorize access="!hasRole('ROLE_ADMIN') && hasRole('ROLE_USER')">

                        <div class="form-group">
                            <label for="passengerFirstName" class="control-label col-xs-3"><fmt:message
                                    key="ticket.passengerFirstName"/></label>

                            <div class="col-xs-9">
                                <input type="text" class="modal-input form-control" id="passengerFirstName"
                                       name="passengerFirstName"
                                       placeholder="Ivan">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="passengerLastName" class="control-label col-xs-3"><fmt:message
                                    key="ticket.passengerLastName"/></label>

                            <div class="col-xs-9">
                                <input type="text" class="modal-input form-control" id="passengerLastName"
                                       name="passengerLastName"
                                       placeholder="Ivan">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="withBaggage" class="control-label col-xs-3"><fmt:message
                                    key="ticket.includeBaggage"/></label>

                            <div class="col-xs-9">
                                <input type="checkbox" class="modal-input form-control" id="withBaggage"
                                       name="withBaggage">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="withPriorityRegistration" class="control-label col-xs-3"><fmt:message
                                    key="ticket.includePriorityRegistration"/></label>

                            <div class="col-xs-9">
                                <input type="checkbox" class="modal-input form-control" id="withPriorityRegistration"
                                       name="withPriorityRegistration">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-xs-offset-3 col-xs-9">
                                <button class="btn btn-primary" type="button" onclick="save()"><fmt:message
                                        key="common.save"/></button>
                            </div>
                        </div>
                    </sec:authorize>
                </form:form>
            </div>
        </div>
    </div>
</div>
</body>

<jsp:include page="fragments/footer.jsp"/>
<script type="text/javascript" src="resources/js/dataTablesUtil.js"></script>
<%--TODO CONSIDER REFACTORING--%>

<sec:authorize access="hasRole('ROLE_ADMIN')">
    <script type="text/javascript" src="resources/js/flightDataTables.js"></script>
</sec:authorize>

<sec:authorize access="!hasRole('ROLE_ADMIN') && hasRole('ROLE_USER')">
    <script type="text/javascript" src="resources/js/purchaseDataTables.js"></script>
</sec:authorize>

<sec:authorize access="!hasRole('ROLE_USER')">
    <script type="text/javascript" src="resources/js/anonymousPurchaseDataTables.js"></script>
</sec:authorize>

</html>
