package week2Testsrc;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import week1src.BankAccount;

class BankAccountTest {

	/*
	 * @Test void testBankAccount() { fail("Not yet implemented"); }
	 */
	@Test
	void testSetName() {
		BankAccount b = new BankAccount("Osemeigah", 2046969, 0);
		b.setName("Osemeigah");
		assertEquals(b.getName(), "Osemeigah");
	}

	@Test
	void testGetName() {
		BankAccount b = new BankAccount("Osemeigah", 2046969, 0);
		assertEquals(b.getName(), "Osemeigah");
	}

	@Test
	void testSetAccountNumber() {
		BankAccount b = new BankAccount("Osemeigah", 2046969, 0);
		b.setAccountNumber(2046969);
		assertEquals(b.getAccountNumber(), 2046969);
	}

	@Test
	void testGetAccountNumber() {
		BankAccount b = new BankAccount("Osemeigah", 2046969, 0);
		assertEquals(b.getAccountNumber(), 2046969);
	}

	@Test
	void testSetAccountBalance() {
		BankAccount b = new BankAccount("Osemeigah", 2046969, 0);
		b.setAccountBalance(0);
		assertTrue(b.getAccountBalance() == 0);
	}

	@Test
	void testGetAccountBalance() {
		BankAccount b = new BankAccount("Osemeigah", 2046969, 0);
		assertTrue(b.getAccountBalance() == 0);
	}

	@Test
	void testDeposit() {
		fail("Not yet implemented");
	}

	@Test
	void testCheckingBalance() {
		fail("Not yet implemented");
	}

	@Test
	void testWithdraw() {
		fail("Not yet implemented");
	}

	@Test
	void testMain() {
		fail("Not yet implemented");
	}

}
