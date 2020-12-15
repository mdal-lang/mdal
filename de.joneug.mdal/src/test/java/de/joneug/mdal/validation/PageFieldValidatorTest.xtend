package de.joneug.mdal.validation

import com.google.inject.Inject
import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.tests.MdalInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertNotNull

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class PageFieldValidatorTest {

	@Inject
	ParseHelper<Model> parseHelper

	@Inject extension ValidationTestHelper

	@Test
	def void testEntityUnknown() {
		// Tests method "checkFieldName"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Description"; Description)
					}
					
					listPage {
						field("Description1")
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.pageField, MdalValidator.PAGE_FIELD_UNKNOWN_FIELD)
	}

}
