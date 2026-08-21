import io.github.treesitter.jtreesitter.Language;
import io.github.carloluis.jtreesitter.eskip.TreeSitterEskip;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

public class TreeSitterEskipTest {
    @Test
    public void testCanLoadLanguage() {
        assertDoesNotThrow(() -> new Language(TreeSitterEskip.language()));
    }
}
