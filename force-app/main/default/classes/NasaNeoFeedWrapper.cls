public class NasaNeoFeedWrapper {
    public Links links;
    public Integer element_count;
    public Map<String, List<NeoObject>> near_earth_objects;

    public class Links {
        public String next;
        public String prev;
        public String self;
    }

    public class NeoObject {
        public NeoLinks links;
        public String id;
        public String neo_reference_id;
        public String name;
        public String nasa_jpl_url;
        public Decimal absolute_magnitude_h;
        public EstimatedDiameter estimated_diameter;
        public Boolean is_potentially_hazardous_asteroid;
        public List<CloseApproachData> close_approach_data;
        public Boolean is_sentry_object;
        public String sentry_data;
    }

    public class NeoLinks {
        public String self;
    }

    public class EstimatedDiameter {
        public Diameter kilometers;
        public Diameter meters;
        public Diameter miles;
        public Diameter feet;
    }

    public class Diameter {
        public Decimal estimated_diameter_min;
        public Decimal estimated_diameter_max;
    }

    public class CloseApproachData {
        public String close_approach_date;
        public String close_approach_date_full;
        public Long epoch_date_close_approach;
        public RelativeVelocity relative_velocity;
        public MissDistance miss_distance;
        public String orbiting_body;
    }

    public class RelativeVelocity {
        public String kilometers_per_second;
        public String kilometers_per_hour;
        public String miles_per_hour;
    }

    public class MissDistance {
        public String astronomical;
        public String lunar;
        public String kilometers;
        public String miles;
    }
}