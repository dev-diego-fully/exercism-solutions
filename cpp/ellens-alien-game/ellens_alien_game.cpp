namespace targets {

    class Alien {

        public:
            int x_coordinate = 0;
            int y_coordinate = 0;
            int health = 3;

            Alien(int x, int y) {
                this->x_coordinate = x;
                this->y_coordinate = y;
            }

            int get_health() {

                return this->health;

            }

            bool hit() {

                if(this->is_alive()) {
                    this->health--;
                }

                return true;
                
            }

            bool is_alive() {

                return this->health > 0;

            }

            bool teleport( int x, int y ) {

                this->x_coordinate = x;
                this->y_coordinate = y;

                return true;

            }

            bool collision_detection( Alien other ) {

                if(this->x_coordinate != other.x_coordinate)
                    return false;
                
                if(this->y_coordinate != other.y_coordinate)
                    return false;
                
                return true;

            }

    };


}  // namespace targets