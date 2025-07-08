# Tarea-modulo3
/*
    🦄 SimpleDEX - Manual de Uso en Remix (Scroll Sepolia)

    Este documento contiene los pasos que debes seguir para desplegar y probar
    tu exchange descentralizado SimpleDEX junto con los tokens ERC-20 TokenA y TokenB.
    Todos los contratos deben estar en la red de prueba Scroll Sepolia.
*/

/* ----------------------------------------------
🛠️ PASO 1: Desplegar los contratos en Remix
---------------------------------------------- */

// Asegurate de tener MetaMask conectada a Scroll Sepolia
// Y seleccionar "Injected Provider - MetaMask" en Remix

// 1.1 Compilar y desplegar TokenA:
// Input del constructor (initialSupply): 10000000000000000000000
// Este número equivale a 10,000 tokens con 18 decimales

// 1.2 Hacer lo mismo con TokenB (igual que TokenA)

// 1.3 Compilar y desplegar SimpleDEX:
// Constructor: necesita dos direcciones (TokenA y TokenB en ese orden)

// Ejemplo:
// TokenA address = 0x6181b5c39b2f80ae3b7b57f6fc554007c2adc88a
// TokenB address = 0xcd256bf310081ab743e0650d7f0d68d925bc1c9e

// Constructor input (en Remix separado por coma):
// 0x6181b5c39b2f80ae3b7b57f6fc554007c2adc88a, 0xcd256bf310081ab743e0650d7f0d68d925bc1c9e

/* ----------------------------------------------
🔐 PASO 2: Aprobar tokens para el contrato SimpleDEX
---------------------------------------------- */

// Abrí el contrato TokenA en Remix (en la sección "At Address")
// Llamá a la función:

// approve(address spender, uint256 amount)
// -> spender: dirección de SimpleDEX
// -> amount: 1000000000000000000000 (1000 tokens, por ejemplo)

// Hacé lo mismo con TokenB

/* ----------------------------------------------
💧 PASO 3: Añadir liquidez al pool
---------------------------------------------- */

// En SimpleDEX llamá a:

// addLiquidity(uint256 amountA, uint256 amountB)
// Ejemplo:
// addLiquidity(1000000000000000000000, 2000000000000000000000)
// (Añade 1000 TokenA y 2000 TokenB)

/* ----------------------------------------------
🔄 PASO 4: Hacer intercambios
---------------------------------------------- */

// swapAforB(uint256 amountAIn)
// Ejemplo: swapAforB(100000000000000000000) -> cambia 100 TokenA por TokenB

// swapBforA(uint256 amountBIn)
// Ejemplo: swapBforA(50000000000000000000) -> cambia 50 TokenB por TokenA

/* ----------------------------------------------
💵 PASO 5: Retirar liquidez
---------------------------------------------- */

// removeLiquidity(uint256 amountA, uint256 amountB)
// Ejemplo:
// removeLiquidity(1000000000000000000000, 2000000000000000000000)

/* ----------------------------------------------
📈 PASO 6: Consultar precios del pool
---------------------------------------------- */

// getPrice(address token)
// Ejemplo: getPrice(TokenA_address)
// Devuelve la relación de intercambio de TokenA respecto a TokenB

/* ----------------------------------------------
📄 PASO 7: Verificar contratos en ScrollScan
---------------------------------------------- */

// Asegurate de usar:
// - Código flatten desde Remix (CTRL+S + botón "Flatten")
// - Compiler version: v0.8.30 (u otra según usaste)
// - Optimization: NO (si no usaste optimización)
// - License: MIT

// Constructor Arguments ABI-encoded:
// TokenA: ejemplo -> 000000000000000000000000000000000000000000000021e19e0c9bab240000
// SimpleDEX: 000000000000000000000000[TokenA]000000000000000000000000[TokenB]

// Reemplazá [TokenA] y [TokenB] por tus direcciones sin el `0x`, pegadas y rellenadas con ceros

/* ----------------------------------------------
