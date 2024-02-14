package week1src;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class CarTest {

	@Test
	void testCar() {
		car c = new car ("peugeot", 70, 60.5);
		assertEquals(c.getModel(),"peugeot");
		assertEquals(c.getTankSize(),70);
		assertEquals(c.getManfMPG(),60.5);
	}

	@Test
	void testSetModel() {
		car c = new car ("peugeot", 70, 60.5);
		assertEquals(c.getModel(),"peugeot");
		c.setModel("kai");
		assertEquals(c.getModel(),"kai");
		 
	}

	@Test
	void testGetModel() {
		car c = new car ("peugeot", 70, 60.5);
		assertEquals(c.getModel(),"peugeot");
	}

	@Test
	void testSetTankSize() {
		car c = new car ("peugeot", 70, 60.5);
		assertEquals(c.getTankSize(),70);
		c.setTankSize(70);
		assertEquals(c.getTankSize(),70);
	}

	@Test
	void testGetTankSize() {
		car c = new car ("peugeot", 70, 60.5);
		assertEquals(c.getTankSize(),70);
		c.setTankSize(70);
		assertEquals(c.getTankSize(),70);
	}

	@Test
	void testEstimateDistance() {
		car c = new car ("peugeot", 70, 60.5);
		assertEquals(c.getManfMPG(),60.5);
		c.setManfMPG(60.5);
		assertEquals(c.getManfMPG(), 60.5);
	}

	
}
