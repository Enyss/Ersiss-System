/** Copyright (c) 2020 The Eriss-System Project Contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE. **/

using Godot;
using System;

public class Player : Node
{

    private static Player instance;
    public static Player Instance { get { return instance; } }
    public Controller baseController;

    private Controller controller;
    public Controller Controller
    {
        get { return Controller; }
        set { SetController(value); }
    }
    public Node lookingAt = null;

    public Pov pov;

    public Player()
    {
        instance = this;
    }
    
    public void SetController(Controller newController)
    {
        //If the controller don't change
        if (newController == controller)
        {
            return;
        }
        //If the controller change
        if (controller != null)
        {
            controller.Desactivate();
        }
        if (newController == null)
        {
            controller = Instance.baseController;
        }
        else
        {
            controller = newController;
        }
        controller.Activate();
    }

    public void ResetController()
    {
        SetController(baseController);
    }
}