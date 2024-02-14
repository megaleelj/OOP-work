package week2src;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class CarTest {

	@Test
	void testCar() {
		car c = new car("Mercedes", 60, 30.5);
		assertEquals(c.getModel(), "Mercedes");
		assertEquals(c.getTankSize(), 60);
		assertEquals(c.getManfMPG(), 30.5);
	}

	@Test
	void testSetModel() {
		car c = new car("Mercedes", 60, 30.5);
		assertEquals(c.getModel(), "Mercedes");
		c.setModel("kai");
		assertEquals(c.getModel(), "kai");

	}

	@Test
	void testGetModel() {
		car c = new car("Mercedes", 60, 30.5);
		assertEquals(c.getModel(), "Mercedes");
	}

	@Test
	void testSetTankSize() {
		car c = new car("Mercedes", 60, 30.5);
		assertEquals(c.getTankSize(), 60);
		c.setTankSize(60);
		assertEquals(c.getTankSize(), 60);
	}

	@Test
	void testGetTankSize() {
		car c = new car("Mercedes", 60, 30.5);
		assertEquals(c.getTankSize(), 60);
		c.setTankSize(60);
		assertEquals(c.getTankSize(), 60);
	}

	@Test
	void testEstimateDistance() {
		car c = new car("Mercedes", 60, 30.5);
		assertEquals(c.getManfMPG(), 30.5);
		c.setManfMPG(30.5);
		assertEquals(c.getManfMPG(), 30.5);
	}

}
