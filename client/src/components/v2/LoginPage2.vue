<template>
  <section class="forms-section">
    <h1 class="section-title">Time Manager</h1>
    <div class="forms">
      <div class="form-wrapper" :class="{ isactive: isActive }">
        <button
          type="button"
          class="switcher switcher-login"
          @click="isActive = true"
        >
          Login
          <span class="underline"></span>
        </button>
        <form class="form form-login" @submit.prevent="loginAction()">
          <fieldset>
            <legend>Please, enter your username and password for login.</legend>
            <div class="input-block">
              <label for="login-username">Username</label>
              <input
                v-model="loginUser.username"
                placeholder="username"
                id="login-username"
                required
              />
            </div>
            <div class="input-block">
              <label for="login-password">Password</label>
              <input
                v-model="loginUser.password"
                id="login-password"
                type="password"
                required
              />
            </div>
          </fieldset>
          <button type="submit" class="btn-login" >Login</button>
        </form>
      </div>
      <div class="form-wrapper" :class="{ isactive: !isActive }">
        <button
          type="button"
          class="switcher switcher-signup"
          @click="isActive = false"
        >
          Sign Up
          <span class="underline"></span>
        </button>
        <form class="form form-signup" @submit.prevent="signUpAction()">
          <fieldset>
            <legend>
              Please, enter your email, password and password confirmation for
              sign up.
            </legend>
            <div class="input-block">
              <label for="signup-email">E-mail</label>
              <input
                v-model="signUpUser.email"
                placeholder="example@example.com"
                id="signup-email"
                type="email"
                required
              />
            </div>
            <div class="input-block">
              <label for="signup-username">Username</label>
              <input
                v-model="signUpUser.username"
                id="signup-username"
                placeholder="Username"
                required
              />
            </div>
            <div class="input-block">
              <label for="signup-password">Password</label>
              <input
                v-model="signUpUser.password"
                id="signup-password"
                type="password"
                required
              />
            </div>
          </fieldset>
          <button type="submit" class="btn-signup">
            Continue
          </button>
        </form>
      </div>
    </div>
  </section>
</template>

<script>
import { mapActions } from "vuex";

export default {
  data() {
    return {
      isActive: true,
      loginUser: {
        username: "",
        password: "",
      },
      signUpUser: {
        username: "",
        email: "",
        password: "",
      },
    };
  },
  methods: {
    ...mapActions({
      login: "currentUser/login",
      signup: "currentUser/signup",
    }),
    async loginAction() {
      const res = await this.login(this.loginUser);
      if (res.status === 200) {
        this.$router.push("/");
      }
    },
    async signUpAction() {
      console.log(this.signUpUser)
      const res = await this.signup(this.signUpUser);
      if (res.status === 200) {
        // const resLogin = await this.login()
        // this.$router.push("/");
      } else {
        alert(res.error);
      }
    },
  },
};
</script>

<style>
@import "@/styles/login.css";
</style>