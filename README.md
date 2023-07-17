# SmartContract_Module2

This is a simple project that is used to built the Smart Contract, and uses the Express.js to connect the MetaMask wallet to Smart Contract and also uses the HTML and JavaScript to built the front end. This project is created so that a front end is built which is connected to the user's MetaMask wallet.

## Getting Start

To built this project we have to follow the following steps:

First, we have to install the Ganache which will help to retrieve the ABI and address of the transaction.
Next, we have to frequectly check whether the web server is properly running in the system or not. This can be checked by performing "node server.js" command in the cmd navigated by the project's directory.
Also, we have to access the web application by opening the web browser and navigating to http://localhost:1725 or any other specified port number.

## Description

### Server.js
    
    //Expree framework in JavaScript
    const express = require("express");
    const path = require("path");
    const app = express();
    
    app.get("/", (req, res) => {
        res.sendFile(path.join(__dirname + "/index.html"));
    })
    
    const server = app.listen(1725);
    const portNumber = server.address().port;
    console.log(`port is running on ${portNumber}`);
This is a simple JavaScript code snippet that demonstrates the usage of the Express framework to create a basic web server. The code sets up an Express application, defines a route for the root URL ("/"), and starts the server.

## Features

outing: The code uses the app.get() method to define a route for the root URL ("/"). When a GET request is made to the root URL, the code responds by sending a file called "index.html" located in the same directory as the script.

Static File Serving: The code utilizes the path module to determine the file path of the "index.html" file. It uses the res.sendFile() method to send the file as a response to the client.

Server Initialization: The code initializes the Express application using express() and assigns it to the app constant. It starts the server by calling the listen() method on the app object, specifying the port number 1725.

Console Logging: The code logs a message to the console, displaying the port number on which the server is running.

### index.js

    <!DOCTYPE html>
    <html>
    <head>
        <title>LINK TO METAMASK</title>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/web3/1.2.7-rc.0/web3.min.js"></script>
        <style>
            body {
                background-image: linear-gradient(245deg, rgba(27, 27, 27, 0.04) 0% , rgba(27, 27, 27, 0.04) 93%,rgba(92, 92, 92, 0.04) 93%, rgba(92, 92, 92, 0.04) 100%),linear-gradient(44deg, rgba(11, 11, 11, 0.04) 0%, rgba(11, 11, 11, 0.04) 39%,rgba(186, 186, 186, 0.04) 39%, rgba(186, 186, 186, 0.04) 100%),linear-gradient(134deg, rgba(178, 178, 178, 0.04) 0%, rgba(178, 178, 178, 0.04) 95%,rgba(237, 237, 237, 0.04) 95%, rgba(237, 237, 237, 0.04) 100%),linear-gradient(322deg, rgba(56, 56, 56, 0.04) 0%, rgba(56, 56, 56, 0.04) 58%,rgba(232, 232, 232, 0.04) 58%, rgba(232, 232, 232, 0.04) 100%),linear-gradient(139deg, rgba(51, 51, 51, 0.04) 0%, rgba(51, 51, 51, 0.04) 62%,rgba(35, 35, 35, 0.04) 62%, rgba(35, 35, 35, 0.04) 100%),linear-gradient(252deg, rgba(9, 9, 9, 0.04) 0%, rgba(9, 9, 9, 0.04) 39%,rgba(174, 174, 174, 0.04) 39%, rgba(174, 174, 174, 0.04) 100%),linear-gradient(229deg, rgba(241, 241, 241, 0.04) 0%, rgba(241, 241, 241, 0.04) 2%,rgba(140, 140, 140, 0.04) 2%, rgba(140, 140, 140, 0.04) 100%),linear-gradient(223deg, rgba(82, 82, 82, 0.04) 0%, rgba(82, 82, 82, 0.04) 36%,rgba(229, 229, 229, 0.04) 36%, rgba(229, 229, 229, 0.04) 100%),linear-gradient(90deg, rgb(245, 16, 17),rgb(177, 69, 207)  );
                height: 100vh;
                font-size: 23px;
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
        <button onclick="getConnectedSites()">GET CONNECTED SITES</button> <br>
        <p id="connectedSite"></p>
        <button onclick="getTransactionAddress()">GET TRANSACTION ADDRESS</button> <br>
        <p id="transactionAddress"></p>
        <button onclick="disconnectMetamask()">DISCONNECT METAMASK</button> <br>
        <p id="disconnectedArea"></p>
    
        <script>
            let account;
            let contract;
    
            const connectMetamask = async () => {
                if (window.ethereum !== "undefined") {
                    const accounts = await ethereum.request({ method: "eth_requestAccounts" });
                    account = accounts[0];
                    document.getElementById("accountArea").innerHTML = account;
                }
            }
    
            const connectContract = async () => {
                const ABI = [
                    // Contract ABI
                ];
                const Address = "0x1aD9647CdDA493c3fF01ab659F47e6175e023008";
                window.web3 = await new Web3(window.ethereum);
                contract = await new window.web3.eth.Contract(ABI, Address);
                document.getElementById("contractArea").innerHTML = "Connected to smart contract";
            }
    
            //disconnect Metamask
            const disconnectMetamask = async () => {
                    await ethereum.request({ method: "wallet_requestPermissions", params: [{ eth_accounts: {} }] });
                    document.getElementById("disconnectedArea").innerHTML = "Metamask disconnected";
            };
    
            // connected sites to metamask
            const getConnectedSites = async () => {
                    const permissions = await ethereum.request({ method: "wallet_getPermissions" });
                    const connectedSites = permissions.map((permission) => permission.parentCapability.origin);
                    document.getElementById("connectedSite").innerHTML = "Connected Sites: " + connectedSites.length;
            };
    
            // transaction account
            const getTransactionAddress = async () => {
                    const latestBlock = await window.web3.eth.getBlock("latest");
                    const transactions = latestBlock.transactions;
                    const lastTransaction = transactions[transactions.length - 1];
                    document.getElementById("transactionAddress").innerHTML = "Latest Transaction Address: " + lastTransaction;
            };
            
        </script>
    </body>
    </html>

This is a simple web page that provides a user interface for interacting with the Metamask browser extension. Metamask allows users to manage their cryptocurrency wallets and interact with blockchain-based applications. The web page offers various functionalities such as connecting to Metamask, connecting to a smart contract, retrieving connected sites, getting the address of the latest transaction, and disconnecting from Metamask.

### Features

Connect to Metamask: By clicking the "LINK TO METAMASK" button, the web page checks if the Metamask extension is installed and requests permission to access the user's accounts. If successful, it displays the user's account address in the "accountArea" section.

Connect to Contract: The "CONNECT TO CONTRACT" button establishes a connection to a specific smart contract on the Ethereum blockchain. It uses the contract's ABI and address to create a connection. Once connected, a message is displayed in the "contractArea" section, indicating that the web page is connected to the smart contract.

Get Connected Sites: Clicking the "GET CONNECTED SITES" button retrieves the list of websites or applications that the user has connected to using Metamask. The number of connected sites is displayed in the "connectedSite" section.

Get Transaction Address: The "GET TRANSACTION ADDRESS" button fetches the address of the latest transaction from the Ethereum blockchain. It displays the transaction address in the "transactionAddress" section.

Disconnect Metamask: Clicking the "DISCONNECT METAMASK" button requests permission to disconnect the web page from Metamask. Once disconnected, a message is shown in the "disconnectedArea" section.


## License
This project is licensed under the MIT License.
