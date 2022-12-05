// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
Enum
1. Gas efficient

Struct
1. similar to C structs or Data classes in Python, etc
2. cannot return a struct (you have to return values as a tuple)
*/

contract StructAndEnum {
    enum Status {
        TODO,
        PENDING,
        ACCEPTED,
        REJECTED,
        CANCELLED
    }
    struct Task {
        string title;
        string descritpion;
        Status status;
    }
    mapping(uint256 => Task) tasks;

    function addTask(uint256 _id, string memory _title, string memory _descritpion) public {
        //method 1
        tasks[_id] = Task(_title, _descritpion, Status.TODO);

        //method 2 - better to use this one
        tasks[_id] = Task({
            title: _title,
            descritpion: _descritpion,
            status: Status.TODO
        });

        //method 3
        Task memory task;
        task.title = _title;
        task.descritpion = _descritpion;
        task.status = Status.TODO;
        tasks[_id] = task;
    }
    function getTask(uint256 _id) public view returns (string memory, string memory, Status){
        return (tasks[_id].title, tasks[_id].descritpion, tasks[_id].status);
    }
}
