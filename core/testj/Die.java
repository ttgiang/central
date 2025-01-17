// File:   rolldice/Die.java
// Description: Models / displays one die.
// Author: Fred Swartz - 2006-11-30 - Placed in public domain.


import java.awt.*;
import javax.swing.*;

public class Die extends JComponent {
    private static final int SPOT_DIAM = 9;  // Diameter of spots

    private int _faceValue;     // value that shows on face of die

    /** Initialize to white background and 60x60 pixels. Initial roll.*/
    public Die() {
        //-- Preferred size is set, but layout may change it.
        setPreferredSize(new Dimension(60,60));
        roll();  // Set to random initial value
    }

    /** Produce random roll in range 1-6.  Causes repaint().
     * @return Result of roll (1-6).
     */
    public int roll() {
        int val = (int)(6*Math.random() + 1);   // Range 1-6
        setValue(val);
        return val;
    }

    /** Returns result of last roll.*/
    public int getValue() {
        return _faceValue;
    }

    /** Sets the value of the Die.  Causes repaint().
     * @param spots Number from 1-6.
     */
    public void setValue(int spots) {
        _faceValue = spots;
        repaint();    // Value has changed, must repaint
    }

    /** Draws spots of die face. */
    @Override public void paintComponent(Graphics g) {
        int w = getWidth();  // Get height and width
        int h = getHeight();

        //... Change to Graphic2D for smoother spots.
        Graphics2D g2 = (Graphics2D)g;  // See note below
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON);

        //... Paint background
        g2.setColor(Color.WHITE);
        g2.fillRect(0, 0, w, h);
        g2.setColor(Color.BLACK);

        g2.drawRect(0, 0, w-1, h-1);  // Draw border

        switch (_faceValue) {
            case 1:
                drawSpot(g2, w/2, h/2);
                break;
            case 3:
                drawSpot(g2, w/2, h/2);
                // Fall thru to next case
            case 2:
                drawSpot(g2, w/4, h/4);
                drawSpot(g2, 3*w/4, 3*h/4);
                break;
            case 5:
                drawSpot(g2, w/2, h/2);
                // Fall thru to next case
            case 4:
                drawSpot(g2, w/4, h/4);
                drawSpot(g2, 3*w/4, 3*h/4);
                drawSpot(g2, 3*w/4, h/4);
                drawSpot(g2, w/4, 3*h/4);
                break;
            case 6:
                drawSpot(g2, w/4, h/4);
                drawSpot(g2, 3*w/4, 3*h/4);
                drawSpot(g2, 3*w/4, h/4);
                drawSpot(g2, w/4, 3*h/4);
                drawSpot(g2, w/4, h/2);
                drawSpot(g2, 3*w/4, h/2);
                break;
        }
    }

    /** Utility method used by paintComponent(). */
    private void drawSpot(Graphics2D g2, int x, int y) {
        g2.fillOval(x-SPOT_DIAM/2, y-SPOT_DIAM/2, SPOT_DIAM, SPOT_DIAM);
    }
}