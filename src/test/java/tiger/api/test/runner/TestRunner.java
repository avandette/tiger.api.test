package tiger.api.test.runner;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

		@Karate.Test
		public Karate runTest() {
			// classpath is the location of your feature files
			// if this path is wrong then you wont be able to run anything
			// tag is to specify with tag to execute with this runner
			return Karate.run("classpath:features")
					.tags("Smoke");
		}
}
