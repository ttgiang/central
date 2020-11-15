import javax.swing.JFrame;
import javax.swing.JLabel;

public class HelloWorldFrame extends JFrame {

	public static void main(String args[]) {
		new HelloWorldFrame();
	}
	HelloWorldFrame() {
		JLabel jlbHelloWorld = new JLabel("Hello World");
		add(jlbHelloWorld);
		this.setSize(100, 100);
		// pack();
		setVisible(true);
	}
}