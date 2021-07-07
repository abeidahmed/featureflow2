import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "custom_elements";

ActiveStorage.start();

import "controllers";
