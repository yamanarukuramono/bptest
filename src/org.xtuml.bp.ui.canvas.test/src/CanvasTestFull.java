import org.junit.runner.RunWith;
import org.junit.runners.Suite;

import junit.framework.TestSuite;
import org.junit.Ignore;

/**
 * Test all areas of the verifier
 */
@Ignore
@RunWith(Suite.class)
@Suite.SuiteClasses({ GlobalsCanvasSuite3.class, CanvasCCPGlobalsTestSuite.class, GlobalsCanvasSuite1.class, GlobalsCanvasSuite2.class,
		})

public class CanvasTestFull extends TestSuite {
}
