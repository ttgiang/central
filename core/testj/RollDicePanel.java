// File:   rolldice/RollDicePanel.java
// Description: Panel of GUI, shows button and two dice.
// Author: Fred Swartz - 2006-11-30 - Placed in public domain.

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

public class RollDicePanel extends JPanel {

    private Die _leftDie;
    private Die _rightDie;

    RollDicePanel() {
        _leftDie  = new Die();
        _rightDie = new Die();

        //...Create the button to roll the dice
        JButton rollButton = new JButton("Spin");
        rollButton.setFont(new Font("Sansserif", Font.PLAIN, 24));

        //... Add listener.
        rollButton.addActionListener(new RollListener());

        //... Layout components
        this.setLayout(new BorderLayout(5, 5));
        this.add(rollButton, BorderLayout.NORTH);
        this.add(_leftDie , BorderLayout.WEST);
        this.add(_rightDie, BorderLayout.EAST);

        this.setBorder(BorderFactory.createEmptyBorder(5,5,5,5));
    }


    private class RollListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            _leftDie.roll();
            _rightDie.roll();
        }
    }
}