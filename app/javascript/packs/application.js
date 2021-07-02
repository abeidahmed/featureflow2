import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage";
import "channels";

ActiveStorage.start();

import "controllers";
