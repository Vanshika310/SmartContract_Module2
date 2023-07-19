# SMART CONTRACT MANAGEMENT PROJECT

## Overview

This project aims to develop a Smart Contract Management system that allows users to create, deploy, and manage smart contracts on a metamask wallet. The system provides a user-friendly interface for interacting with smart contracts, simplifying the process of contract creation, execution, and monitoring. This project mainly contains three files. server.js, Simple.sol, and index.html. All three files have their uses and functionalities. 

## Getting Start

To build this project we have to follow the following steps:

First, we have to install the Ganache which will act as a network for my metamask wallet. Next, we have to frequently check whether the web server is properly running in the system or not. This can be prevented by performing the "node server.js" command in the cmd navigated by the project's directory. Also, we have to access the web application by opening the web browser and navigating to http://localhost:1725 or any other specified port number.

## Description

### Server.js

	//Express framework in JavaScript
	const express = require("express");
	const path = require("path");
	const app = express();
	
	app.get("/", (req, res) => {
	    res.sendFile(path.join(__dirname + "/index.html"));
	})
	
	const server = app.listen(1725);
	const portNumber = server.address().port;
	console.log(`port is running on ${portNumber}`);

This project demonstrates the use of the Express framework to create a basic web server in JavaScript. Express is a popular Node.js framework that simplifies the process of building web applications and APIs. To start the Express server, execute the following command in the project directory: 'npm start'. The server will listen on a specified port (in this case, port 1725) and print a message in the console indicating the port number. The Express server in this project defines a single route that handles requests to the root URL ("/"). When a client makes a GET request to the root URL, the server responds by sending the index.html file located in the project directory. To customize the server behavior or add additional routes, you can modify the app.get() function in the index.js file. The callback function within app.get() is executed whenever a request is made to the specified route. You can define the desired response logic within this callback function.

### Simple.sol

	// SPDX-License-Identifier: MIT
	
	pragma solidity ^0.8.0;
	
	contract Permission {
	    mapping(address => bool) private permissions;
	
	    event PermissionSet(address indexed account, bool hasPermission);
	
	    constructor() {
	        permissions[msg.sender] = true; 
	    }
	
	    modifier onlyOwner() {
	        require(permissions[msg.sender], "Only the contract owner can set permissions");
	        _;
	    }
	
	    function setPermissionForAddress(address account, bool hasPermission) external onlyOwner {
	        permissions[account] = hasPermission;
	        emit PermissionSet(account, hasPermission);
	    }
	
	    function checkPermissionForAddress(address account) public view returns (bool) {
	        return permissions[account];
	    }
	}

This Solidity smart contract demonstrates a simple permission management system. It allows the contract owner to grant or revoke permission for specific addresses. The contract owner has the sole authority to set permissions for other accounts. 

setPermissionForAddress: Allows the contract owner to set the permission status for a specific address. Only the contract owner can execute this function. It has three parameters. 
a) account: The address for which the permission status needs to be set.
b) hasPermission: A boolean indicating whether the address should have permission (true) or not (false).

And one Modifier:
a) onlyOwner: Restricts the function execution to the contract owner.

2. checkPermissionForAddress
Allows anyone to check the permission status for a specific address.

Parameters:
a) account: The address for which the permission status needs to be checked.

Returns:
a) bool: The permission status (true if the address has permission, false otherwise).

3. PermissionSet event
Emits an event whenever the permission status is set for an address.

Parameters:
a) account: The address for which the permission status is set.
b) hasPermission: The permission status (true if the address is granted permission, false if permission is revoked).

### index.html

	<!DOCTYPE html>
	<html>
	<head>
	    <title>LINK TO METAMASK</title>
	    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/web3/1.2.7-rc.0/web3.min.js"></script>
	    <style>
	        body {
	            background-image: linear-gradient(245deg, rgba(27, 27, 27, 0.04) 0% , rgba(27, 27, 27, 0.04) 93%,rgba(92, 92, 92, 0.04) 93%, rgba(92, 92, 92, 0.04) 100%),linear-gradient(44deg, rgba(11, 11, 11, 0.04) 0%, rgba(11, 11, 11, 0.04) 39%,rgba(186, 186, 186, 0.04) 39%, rgba(186, 186, 186, 0.04) 100%),linear-gradient(134deg, rgba(178, 178, 178, 0.04) 0%, rgba(178, 178, 178, 0.04) 95%,rgba(237, 237, 237, 0.04) 95%, rgba(237, 237, 237, 0.04) 100%),linear-gradient(322deg, rgba(56, 56, 56, 0.04) 0%, rgba(56, 56, 56, 0.04) 58%,rgba(232, 232, 232, 0.04) 58%, rgba(232, 232, 232, 0.04) 100%),linear-gradient(139deg, rgba(51, 51, 51, 0.04) 0%, rgba(51, 51, 51, 0.04) 62%,rgba(35, 35, 35, 0.04) 62%, rgba(35, 35, 35, 0.04) 100%),linear-gradient(252deg, rgba(9, 9, 9, 0.04) 0%, rgba(9, 9, 9, 0.04) 39%,rgba(174, 174, 174, 0.04) 39%, rgba(174, 174, 174, 0.04) 100%),linear-gradient(229deg, rgba(241, 241, 241, 0.04) 0%, rgba(241, 241, 241, 0.04) 2%,rgba(140, 140, 140, 0.04) 2%, rgba(140, 140, 140, 0.04) 100%),linear-gradient(223deg, rgba(82, 82, 82, 0.04) 0%, rgba(82, 82, 82, 0.04) 36%,rgba(229, 229, 229, 0.04) 36%, rgba(229, 229, 229, 0.04) 100%),linear-gradient(90deg, rgb(245, 16, 17),rgb(177, 69, 207)  );
	            height: 100vh;
	            font-size: 21px;
	            text-align: center;
	        }
	        button {
	            cursor: pointer;
	            text-decoration:none ;
	            background-color: transparent;
	            font-size: inherit;
	            font-family: inherit;
	            padding: 0;
	            margin: 0;
	        }
	
	        button:hover {
	            background-color: rgb(105, 198, 235);
	        }
	    </style>
	</head>
	<body>
	    <button onclick ="connectMetamask()" >LINK TO METAMASK</button> <br>
	    <p id="accountArea"></p>
	    <button onclick="connectContract()">CONNECT TO CONTRACT</button> <br>
	    <p id="contractArea"></p>
	    <button onclick="setPermission()">SET PERMISSION</button> <br>
	    <p id="permissionArea"></p>
	    <button onclick="checkPermission()">CHECK PERMISSION</button> <br>
	    <p id="checkPermissionArea"></p>
	    <button onclick="disconnectMetamask()">DISCONNECT METAMASK</button> <br>
	    <p id="disconnectedArea"></p>
	
	    <script>
	        let account;
	
	        const connectMetamask = async () => {
	            if (window.ethereum !== "undefined") {
	                const accounts = await ethereum.request({ method: "eth_requestAccounts" });
	                account = accounts[0];
	                document.getElementById("accountArea").innerHTML = account;
	            }
	        };
	
	        const connectContract = async () => {
	            const ABI = [
	                {
	                    "inputs": [],
	                    "stateMutability": "nonpayable",
	                    "type": "constructor"
	                },
	                {
	                    "anonymous": false,
	                    "inputs": [
	                        {
	                            "indexed": true,
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        },
	                        {
	                            "indexed": false,
	                            "internalType": "bool",
	                            "name": "hasPermission",
	                            "type": "bool"
	                        }
	                    ],
	                    "name": "PermissionSet",
	                    "type": "event"
	                },
	                {
	                    "inputs": [
	                        {
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        }
	                    ],    
	                    "name": "checkPermissionForAddress",
	                    "outputs": [
	                        {
	                            "internalType": "bool",
	                            "name": "",
	                            "type": "bool"
	                        }
	                    ],
	                    "stateMutability": "view",
	                    "type": "function"
	                },
	                {
	                    "inputs": [
	                        {
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        },
	                        {
	                            "internalType": "bool",
	                            "name": "hasPermission",
	                            "type": "bool"
	                        }
	                    ],
	                    "name": "setPermissionForAddress",
	                    "outputs": [],
	                    "stateMutability": "nonpayable",
	                    "type": "function"
	                }
	            ];
	            
	            const Address = "0x1A9bE1E97233b3eeAa47f40E5283EC3F95AB22d0";
	            window.web3 = await new Web3(window.ethereum);
	            contract = await new window.web3.eth.Contract(ABI, Address);
	            document.getElementById("contractArea").innerHTML = "Connected to smart contract";
	        };
	
	        const setPermission = async () => {
	            const targetAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138"; 
	            const hasPermission = false; 
	            const ABI = [
	                        
	                {
	                    "inputs": [],
	                    "stateMutability": "nonpayable",
	                    "type": "constructor"
	                },
	                {
	                    "anonymous": false,
	                    "inputs": [
	                        {
	                            "indexed": true,
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        },
	                        {
	                            "indexed": false,
	                            "internalType": "bool",
	                            "name": "hasPermission",
	                            "type": "bool"
	                        }
	                    ],
	                    "name": "PermissionSet",
	                    "type": "event"
	                },
	                {
	                    "inputs": [
	                        {
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        }
	                        ],    
	                    "name": "checkPermissionForAddress",
	                    "outputs": [
	                        {
	                            "internalType": "bool",
	                            "name": "",
	                            "type": "bool"
	                        }
	                    ],
	                    "stateMutability": "view",
	                    "type": "function"
	                },
	                {
	                    "inputs": [
	                        {
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        },
	                        {
	                            "internalType": "bool",
	                            "name": "hasPermission",
	                            "type": "bool"
	                        }
	                    ],
	                    "name": "setPermissionForAddress",
	                    "outputs": [],
	                    "stateMutability": "nonpayable",
	                    "type": "function"
	                }
	            ];
	            const Address = "0x1A9bE1E97233b3eeAa47f40E5283EC3F95AB22d0";
	            window.web3 = await new Web3(window.ethereum);
	            contract = await new window.web3.eth.Contract(ABI, Address);
	
	            try {
	                await contract.methods.setPermissionForAddress(targetAddress, hasPermission).send({ from: account });
	                document.getElementById("permissionArea").innerHTML = "Permission set successfully";
	            } catch (error) {
	                console.error(error);
	                document.getElementById("permissionArea").innerHTML = "Error setting permission";
	            }
	        };
	
	        const checkPermission = async () => {
	            const targetAddress = "0x24ea0CB1F6Ece8fAC933f64E8f64795eDF3DEa86"; // Replace with the address you want to check permission for
	            const ABI = [
	            
	                {
	                    "inputs": [],
	                    "stateMutability": "nonpayable",
	                    "type": "constructor"
	                },
	                {
	                    "anonymous": false,
	                    "inputs": [
	                        {
	                            "indexed": true,
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        },
	                        {
	                            "indexed": false,
	                            "internalType": "bool",
	                            "name": "hasPermission",
	                            "type": "bool"
	                        }
	                    ],
	                    "name": "PermissionSet",
	                    "type": "event"
	                },
	                {
	                    "inputs": [
	                        {
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        }
	                        ],    
	                    "name": "checkPermissionForAddress",
	                    "outputs": [
	                        {
	                            "internalType": "bool",
	                            "name": "",
	                            "type": "bool"
	                        }
	                    ],
	                    "stateMutability": "view",
	                    "type": "function"
	                },
	                {
	                    "inputs": [
	                        {
	                            "internalType": "address",
	                            "name": "account",
	                            "type": "address"
	                        },
	                        {
	                            "internalType": "bool",
	                            "name": "hasPermission",
	                            "type": "bool"
	                        }
	                    ],
	                    "name": "setPermissionForAddress",
	                    "outputs": [],
	                    "stateMutability": "nonpayable",
	                    "type": "function"
	                }
	            ];
	            const Address = "0x1A9bE1E97233b3eeAa47f40E5283EC3F95AB22d0";
	            window.web3 = await new Web3(window.ethereum);
	            contract = await new window.web3.eth.Contract(ABI, Address);
	
	            try {
	                const hasPermission = await contract.methods.checkPermissionForAddress(targetAddress).call();
	                document.getElementById("checkPermissionArea").innerHTML = `Permission: ${hasPermission}`;
	            } catch (error) {
	                console.error(error);
	                document.getElementById("checkPermissionArea").innerHTML = "Error checking permission";
	            }
	        };
	
	
	        //disconnect Metamask
	        const disconnectMetamask = async () => {
	                await ethereum.request({ method: "wallet_requestPermissions", params: [{ eth_accounts: {} }] });
	                document.getElementById("disconnectedArea").innerHTML = "Metamask disconnected";
	        };
	
	
	        
	    </script>
	</body>
	</html>


This HTML document demonstrates the integration of the Metamask wallet with a smart contract. It provides a user interface with buttons to connect Metamask, connect to the smart contract, set permission, check permission, and disconnect Metamask.

Connect Metamask: Click the "LINK TO METAMASK" button to connect your Metamask wallet to the integration. If Metamask is properly installed and set up, it will prompt you to connect and authorize access.

Connect to Contract: After connecting Metamask, click the "CONNECT TO CONTRACT" button to establish a connection to the smart contract. Ensure you replace the ABI and Address variables in the connectContract function with the actual ABI and address of your deployed contract.

Set Permission: Once connected to the contract, you can set permissions by clicking the "SET PERMISSION" button. Replace the targetAddress variable in the setPermission function with the address for which you want to set the permission. Modify the hasPermission variable to indicate whether the address should have permission (true) or not (false).

Check Permission: You can check the permission for a specific address by clicking the "CHECK PERMISSION" button. Replace the targetAddress variable in the checkPermission function with the address for which you want to check the permission.

Disconnect Metamask: To disconnect Metamask, click the "DISCONNECT METAMASK" button. It will revoke the connection permissions and display a message indicating that Metamask is disconnected.


## Lincense 

This project is licensed under the MIT License.












 
