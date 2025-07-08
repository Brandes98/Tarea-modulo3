// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract SimpleDEX {
    address public owner;
    IERC20 public tokenA;
    IERC20 public tokenB;

    uint256 public reserveA;
    uint256 public reserveB;

    event LiquidityAdded(uint256 amountA, uint256 amountB);
    event LiquidityRemoved(uint256 amountA, uint256 amountB);
    event SwappedAforB(uint256 amountAIn, uint256 amountBOut);
    event SwappedBforA(uint256 amountBIn, uint256 amountAOut);

    constructor(address _tokenA, address _tokenB) {
        owner = msg.sender;
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external onlyOwner {
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "Transfer TokenA failed");
        require(tokenB.transferFrom(msg.sender, address(this), amountB), "Transfer TokenB failed");

        reserveA += amountA;
        reserveB += amountB;

        emit LiquidityAdded(amountA, amountB);
    }

    function removeLiquidity(uint256 amountA, uint256 amountB) external onlyOwner {
        require(amountA <= reserveA && amountB <= reserveB, "Insufficient reserves");

        reserveA -= amountA;
        reserveB -= amountB;

        require(tokenA.transfer(msg.sender, amountA), "Transfer TokenA failed");
        require(tokenB.transfer(msg.sender, amountB), "Transfer TokenB failed");

        emit LiquidityRemoved(amountA, amountB);
    }

    function swapAforB(uint256 amountAIn) external {
    require(amountAIn > 0, "Amount must be greater than zero");

    uint256 amountBOut = getAmountOut(amountAIn, reserveA, reserveB);
    require(amountBOut > 0, "Swap output is zero");
    require(amountBOut <= reserveB, "Not enough liquidity for TokenB");

    bool successA = tokenA.transferFrom(msg.sender, address(this), amountAIn);
    require(successA, "Transfer TokenA failed");

    bool successB = tokenB.transfer(msg.sender, amountBOut);
    require(successB, "Transfer TokenB failed");

    reserveA += amountAIn;
    reserveB -= amountBOut;

    emit SwappedAforB(amountAIn, amountBOut);
}


    function swapBforA(uint256 amountBIn) external {
    require(amountBIn > 0, "Amount must be greater than zero");

    uint256 amountAOut = getAmountOut(amountBIn, reserveB, reserveA);
    require(amountAOut > 0, "Swap output is zero");
    require(amountAOut <= reserveA, "Not enough liquidity for TokenA");

    bool successB = tokenB.transferFrom(msg.sender, address(this), amountBIn);
    require(successB, "Transfer TokenB failed");

    bool successA = tokenA.transfer(msg.sender, amountAOut);
    require(successA, "Transfer TokenA failed");

    reserveB += amountBIn;
    reserveA -= amountAOut;

    emit SwappedBforA(amountBIn, amountAOut);
}


    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256) {
        // Fórmula del producto constante sin comisión
        uint256 numerator = amountIn * reserveOut;
        uint256 denominator = reserveIn + amountIn;
        return numerator / denominator;
    }

    function getPrice(address _token) external view returns (uint256) {
        if (_token == address(tokenA)) {
            require(reserveA > 0, "No liquidity for TokenA");
            return (reserveB * 1e18) / reserveA;
        } else if (_token == address(tokenB)) {
            require(reserveB > 0, "No liquidity for TokenB");
            return (reserveA * 1e18) / reserveB;
        } else {
            revert("Invalid token address");
        }
    }
}
