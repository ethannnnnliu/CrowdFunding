import React from 'react';
import ReactDom from 'react-dom/client';
import { BrowserRouter as Router} from 'react-router-dom';
import { ChainId, ThirdwebProvider } from '@thirdweb-dev/react';
import { Gnosis } from "@thirdweb-dev/chains";
import { sepolia } from "thirdweb/chains";

const root = ReactDom.createRoot(document.getElementById('root'));

root.render(
    <ThirdwebProvider desiredChainId={ChainId.sepolia}>
        <Router>
        </Router>
    </ThirdwebProvider>
)