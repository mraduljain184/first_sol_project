// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TodoList {
    struct Task {
        uint256 id;
        string content;
        bool completed;
        uint256 createdAt;
    }

    mapping(address => Task[]) private userTasks;
    uint256 private nextTaskId;

    event TaskCreated(address indexed user, uint256 taskId, string content);
    event TaskCompleted(address indexed user, uint256 taskId);
    event TaskDeleted(address indexed user, uint256 taskId);

    modifier validTaskId(uint256 _taskId) {
        require(_taskId < userTasks[msg.sender].length, "Invalid task ID");
        _;
    }

    function createTask(string calldata _content) external {
        Task memory newTask = Task({
            id: nextTaskId,
            content: _content,
            completed: false,
            createdAt: block.timestamp
        });

        userTasks[msg.sender].push(newTask);
        emit TaskCreated(msg.sender, nextTaskId, _content);

        nextTaskId++;
    }

    function completeTask(uint256 _taskId) external validTaskId(_taskId) {
        Task storage task = userTasks[msg.sender][_taskId];
        require(!task.completed, "Task already completed");
        task.completed = true;
        emit TaskCompleted(msg.sender, _taskId);
    }

    function deleteTask(uint256 _taskId) external validTaskId(_taskId) {
        delete userTasks[msg.sender][_taskId];
        emit TaskDeleted(msg.sender, _taskId);
    }

    function getMyTasks() external view returns (Task[] memory) {
        return userTasks[msg.sender];
    }
}