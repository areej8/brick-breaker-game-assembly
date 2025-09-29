# 🧱 Brick Breaker (MASM x86 + Irvine32)

A simple **Brick Breaker** game written entirely in **x86 Assembly (MASM)** using the **Irvine32** library.



## ⚙️ Requirements

- Visual Studio (recommended IDE)
- Irvine32 Library

📺 **Setup Video:** [How to Download Visual Studio and Set Up MASM + Irvine32](https://youtu.be/81UUI8kO1LE?si=MzE0FAMB6aiMbGcF)



## 🎮 Game Description

In this game, the player controls a **paddle** to bounce a **ball** and break all the **bricks** at the top of the screen.

- If the ball touches the bottom, the player loses a **life**.
- The player starts with **3 lives**.
- A **timer** is displayed on the screen.
- The goal is to **clear all bricks** across multiple levels **before time runs out**.


## 🔥 Levels

### Level 1  
- Standard gameplay.

### Level 2  
- Ball speed increases.  
- Paddle becomes shorter.  
- Bricks require **2 hits** to break (and **change color** after the first hit).

### Level 3  
- Ball speed increases further.  
- Some bricks become **unbreakable** (ball bounces back).  
- Normal bricks require **3 hits** to break.  
- One **special brick** removes up to **5 random bricks** when hit.

## MENU
<img width="1039" height="581" alt="sc1" src="https://github.com/user-attachments/assets/15409110-2750-4815-b7d1-692c971a589d" />

## LEVEL 1
<img width="1128" height="636" alt="Capture" src="https://github.com/user-attachments/assets/cbb7a5d1-4e91-4ab3-a78d-fbf7a1f95dec" />

## LEVEL 2
<img width="1131" height="633" alt="Capture1" src="https://github.com/user-attachments/assets/0816cf7f-43e7-4c92-bba2-0db0270c7320" />

## LEVEL 3
<img width="1137" height="617" alt="Capture3" src="https://github.com/user-attachments/assets/f40a8bf4-9c86-4d85-88a5-4d2483c08297" />

## 🧪 Note 

For demonstration, **not all bricks** need to be removed to move to the next level or win.

You can modify this behavior in the code:

```asm
dec remainingBricks
cmp remainingBricks, 10    ; Change this number to adjust progression
jne ContinueGame
call callLevel2            
```
