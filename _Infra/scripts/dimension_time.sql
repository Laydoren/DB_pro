DO $$
BEGIN

    CREATE SEQUENCE IF NOT EXISTS seq_dim_time;
    CREATE TABLE IF NOT EXISTS dim_time
    (
        id INT PRIMARY KEY DEFAULT nextval('public.seq_dim_time'),
        month_start DATE NOT NULL,
        month_end DATE NOT NULL,
        month_name TEXT NOT NULL,
        year INT NOT NULL,
        quarter_number INT NOT NULL,
        quarter_name TEXT NOT NULL
    );

END $$;


DO $$
BEGIN

    DELETE FROM dim_time;

    INSERT INTO dim_time(month_start, month_end, month_name, year, quarter_number, quarter_name)
        SELECT
            dt::DATE,
            (dt + INTERVAL '1 month' - INTERVAL '1 day')::DATE,
            to_char(dt, 'Month'),
            to_char(dt, 'YYYY')::INT,
            to_char(dt, 'Q')::INT,
            to_char(dt, 'Q') || ' квартал'
        FROM generate_series('2007-01-01'::DATE, '2024-12-01'::DATE, INTERVAL '1 month') AS dt
        ORDER BY dt;

END $$;


SELECT * FROM dim_time;