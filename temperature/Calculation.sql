-- Function to calculate temperature correction using linear interpolation
CREATE OR REPLACE FUNCTION calculate_temperature_correction(target_temperature numeric)
RETURNS numeric AS $$
DECLARE
    lower_temp numeric;
    upper_temp numeric;
    lower_corr numeric;
    upper_corr numeric;
    correction numeric;
BEGIN
    -- Find the nearest lower and upper temperature values
    SELECT temperature, correction INTO lower_temp, lower_corr
    FROM temperature_correction
    WHERE temperature <= target_temperature
    ORDER BY temperature DESC
    LIMIT 1;

    SELECT temperature, correction INTO upper_temp, upper_corr
    FROM temperature_correction
    WHERE temperature >= target_temperature
    ORDER BY temperature ASC
    LIMIT 1;

    -- Perform linear interpolation
    IF lower_temp IS NOT NULL AND upper_temp IS NOT NULL AND lower_temp <> upper_temp THEN
        correction := lower_corr + (upper_corr - lower_corr) * (target_temperature - lower_temp) / (upper_temp - lower_temp);
    ELSE
        correction := COALESCE(lower_corr, upper_corr);
    END IF;

    RETURN correction;
END;
$$ LANGUAGE plpgsql;

-- Example usage of the function
SELECT calculate_temperature_correction(15);  -- Example target temperature