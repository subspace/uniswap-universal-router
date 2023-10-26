// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import {V2SwapRouter} from './modules/uniswap/v2/V2SwapRouter.sol';
import {V3SwapRouter} from './modules/uniswap/v3/V3SwapRouter.sol';

abstract contract CalldataOptRouter is V2SwapRouter, V3SwapRouter { 

    error TooLargeOfNumber(); 

    uint256 constant AMOUNT_IN_OFFSET = 2; 

    function v2SwapExactTokenForToken();
    function v2SwapTokenForExactToken();
    function v2SwapExactETHForToken();
    function v2SwapTokenForExactETH();
    function v3SwapExactTokenForToken();
    function v3SwapTokenForExactToken();
    function v3SwapExactETHForToken();
    function v3SwapTokenForExactETH();

    function _calcuateAmount(bytes calldata swapInfo, uint256 offset) internal pure returns (uint256)
    {
        uint8 numBytes = uint8(bytes1(swapInfo[offset]));
        if (numBytes >= 32) revert TooLargeOfNumber();
        bytes memory rawBytes  = swapInfo[offset+1:offset+1+numBytes];
        return _bytesToUint(rawBytes); 
    }

    function _bytesToUint(bytes memory b) internal pure returns (uint256){
        uint256 number = uint256(bytes32(b));
        return number;
    }
}