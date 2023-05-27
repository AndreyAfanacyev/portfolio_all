const express = require('express');
const app = express();
const port = 8081;
const path = require('path');
const session = require('express-session');

const passport = require('passport');
const YandexStrategy = require('passport-yandex').Strategy;

const VKontakteStrategy = require('passport-vkontakte').Strategy;

app.use(session({ secret: "supersecret", resave: true, saveUninitialized: true }));

let Users = [{'login': 'admin', 'email':'Aks-fam@yandex.ru'},
            {'login': 'local_js_god', 'email':'ilia-gossoudarev@yandex.ru'}];

const findUserByLogin = (login) => {
    return Users.find((element)=> {
        return element.login == login;
    })
}

const findUserByEmail = (email) => {
    return Users.find((element)=> {
        return element.email.toLowerCase() == email.toLowerCase();
    })
}

app.use(passport.initialize());
app.use(passport.session());


passport.serializeUser((user, done) => {
    done(null, user.login);
  });
  //user - объект, который Passport создает в req.user
passport.deserializeUser((login, done) => {
    user = findUserByLogin(login);
        done(null, user);
});

passport.use(new YandexStrategy({
    clientID: 'client_id',
    clientSecret: 'client_secret',
    callbackURL: "http://prikladnyeit.ru:8081/auth/yandex/callback"
  },
  (accessToken, refreshToken, profile, done) => {
    let user = findUserByEmail(profile.emails[0].value);
    if (user) {
        user.profile = profile;
        return done(null, user);
    } else {
        // create user
        Users.push({'login': profile.id, 'email': profile.emails[0].value});
        user = Users[Users.length - 1];
        
        user.profile = profile;
        return done(null, user);
    }
  }
));

passport.use(
    new VKontakteStrategy(
        {
            clientID: 'client_id',
            clientSecret: 'client_secret',
            callbackURL: 'http://prikladnyeit.ru:8081/auth/vkontakte/callback',
        },
        (accessToken, refreshToken, params, profile, done) => {
            let user = findUserByLogin(profile.id);

            if (user) {
                user.profile = profile;
                return done(null, user);
            }
            else {
                // create user
                Users.push({'login': profile.id, 'email': 'vkontakte'});
                user = Users[Users.length - 1];

                user.profile = profile;
                return done(null, user);
            }
        }
    )
);

const isAuth = (req, res, next)=> {
    if (req.isAuthenticated()) return next();

    res.redirect('/sorry');
}


app.get('/', (req, res)=> {
    res.sendFile(path.join(__dirname, 'main.html'));
});
app.get('/sorry', (req, res)=> {
    res.sendFile(path.join(__dirname, 'sorry.html'));
});
app.get('/auth/yandex', passport.authenticate('yandex'));

app.get('/auth/yandex/callback', passport.authenticate('yandex', { failureRedirect: '/sorry', successRedirect: '/private' }));

app.get('/auth/vkontakte', passport.authenticate('vkontakte'));

app.get('/auth/vkontakte/callback', passport.authenticate('vkontakte', { successRedirect: '/private', failureRedirect: '/sorry'}));

app.get('/private', isAuth, (req, res)=>{
    res.send(req.user);
});



app.listen(port, () => console.log(`App listening on port ${port}!`))