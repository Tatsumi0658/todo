<template>
  <div>
    <ul id="dropdown" class="dropdown-content">
      <!--<li>
        <a href="/">Top</a>
      </li>
      <li>
        <a href="/about">About</a>
      </li>
      <li>
        <a href="/contact">Contact</a>
      </li>-->
      <li>
        <router-link to="/">Top</router-link>
      </li>
      <li>
        <router-link to="/about">About</router-link>
      </li>
      <li>
        <router-link to="/contact">Contact</router-link>
      </li>
    </ul>
    <nav>
      <div class="nav-wrapper container">
        <a href="/" class="brand-logo left">Todo Application</a>
        <ul class="right hide-on-med-and-down">
          <li>
            <a href="#">Top</a>
          </li>
          <li>
            <a href="#">About</a>
          </li>
          <li>
            <a href="#">Contact</a>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>
