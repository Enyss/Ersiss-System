/*
 * Copyright (c) 2020 The Eriss-System Project Contributors
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * */

using Godot;

public class BatteryUI : Node
{
    [Export] public float maxCapacity;
    [Export] public float capacity;
    [Export] public float current;
    [Export] public float voltage;

    public override void _Process(float delta)
    {
        // return;
        float p = capacity/maxCapacity;
        GetNode<ColorRect>("VBoxContainer/Bar/Background/ColorRect").AnchorRight = p;
        GetNode<Label>("VBoxContainer/Bar/Background/Label").Text = $"{p*100} %";
        GetNode<Label>("VBoxContainer/Legend/Label").Text = 
            $@"Capacity : {capacity} Ah
            Amperage : {current} A
            Voltage : {voltage} V";
    }
}