/**
 * Created by nasulla on 22/06/2014.
 */
import java.beans.PropertyEditorSupport
import java.text.ParseException
import org.apache.commons.lang.time.DateUtils
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry

class CustomPropertyEditorRegistrar implements PropertyEditorRegistrar {
    def dateEditor

    void registerCustomEditors(PropertyEditorRegistry registry) {
        registry.registerCustomEditor(Date.class, dateEditor)
    }
}

