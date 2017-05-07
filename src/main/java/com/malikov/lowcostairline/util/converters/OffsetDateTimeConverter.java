package com.malikov.lowcostairline.util.converters;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.time.OffsetDateTime;
import java.util.Objects;

/**
 * @author Yurii Malikov
 */
@Converter(autoApply = true)
public class OffsetDateTimeConverter implements
        AttributeConverter<OffsetDateTime, String> {

    /**
     * @return a value as a String such as 2014-12-03T10:15:30+01:00
     * @see OffsetDateTime#toString()
     */
    @Override
    public String convertToDatabaseColumn(OffsetDateTime entityValue) {
        return Objects.toString(entityValue, null);
    }

    @Override
    public OffsetDateTime convertToEntityAttribute(String databaseValue) {
        return OffsetDateTime.parse(databaseValue);
    }
}
