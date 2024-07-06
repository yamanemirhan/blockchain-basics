// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Online Course Registration Example
contract FullContract {
    enum CourseStatus {
        Open,
        Closed,
        Canceled
    }

    struct Course {
        string name;
        uint256 price;
        uint256 capacity;
        uint256 enrolledStudents;
        CourseStatus status;
    }

    mapping(uint256 => Course) public courses;
    mapping(address => mapping(uint256 => bool)) public studentEnrollments;

    address payable public owner;
    uint256 public courseCount;

    event CourseCreated(uint256 courseId, string name, uint256 price);
    event StudentEnrolled(uint256 courseId, address student);
    event CourseStatusChanged(uint256 courseId, CourseStatus newStatus);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    modifier courseExists(uint256 _courseId) {
        require(_courseId > 0 && _courseId <= courseCount, "Course does not exist");
        _;
    }

    function createCourse(string memory _name, uint256 _price, uint256 _capacity) public onlyOwner {
        courseCount++;
        courses[courseCount] = Course(_name, _price, _capacity, 0, CourseStatus.Open);
        emit CourseCreated(courseCount, _name, _price);
    }

    function enrollInCourse(uint256 _courseId) public payable courseExists(_courseId) {
        Course storage course = courses[_courseId];
        require(course.status == CourseStatus.Open, "Course is not open for enrollment");
        require(course.enrolledStudents < course.capacity, "Course is full");
        require(msg.value >= course.price, "Insufficient payment");
        require(!studentEnrollments[msg.sender][_courseId], "Already enrolled in this course");

        course.enrolledStudents++;
        studentEnrollments[msg.sender][_courseId] = true;

        if (course.enrolledStudents == course.capacity) {
            course.status = CourseStatus.Closed;
            emit CourseStatusChanged(_courseId, CourseStatus.Closed);
        }

        (bool sent, ) = owner.call{value: msg.value}("");
        require(sent, "Failed to send Ether");

        emit StudentEnrolled(_courseId, msg.sender);
    }

    function changeCourseStatus(uint256 _courseId, CourseStatus _newStatus) public onlyOwner courseExists(_courseId) {
        require(_newStatus != courses[_courseId].status, "New status must be different");
        courses[_courseId].status = _newStatus;
        emit CourseStatusChanged(_courseId, _newStatus);
    }

    function getCourseInfo(uint256 _courseId) public view courseExists(_courseId) returns (string memory, uint256, uint256, uint256, CourseStatus) {
        Course memory course = courses[_courseId];
        return (course.name, course.price, course.capacity, course.enrolledStudents, course.status);
    }

}