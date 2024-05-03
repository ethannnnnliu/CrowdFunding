import React from "react";
import ReactDOM from 'react-dom/client'
import { Route, BrowserRouter as Router, Routes } from 'react-router-dom';
import { ChainId, ThirdwebProvider } from '@thirdweb-dev/react';

import App from "./App";
import './index.css';

const root = ReactDOM.createRoot(document.getElementById('root'));
 
root.render(
    <ThirdwebProvider desiredChainID={ChainId.Sepolia}>
        <Router>
            <App />
        </Router>
    </ThirdwebProvider>
)