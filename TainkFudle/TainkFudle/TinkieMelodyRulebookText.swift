import Foundation

enum TinkieMelodyGateResult {
    case melodyOpened
    case melodyBlocked(String)
}

enum TinkieMelodyRulebookVerse {
    static let eulaTuneBody = """
Welcome to Tinkie. Tinkie is a music guessing space built around voices, song cues, quick answers, and respectful sound-based play.

You must read and agree to this EULA before registering or logging in.

1. Tinkie has no tolerance for objectionable content or abusive users. Do not create, post, perform, request, or promote content involving child harm, sexual exploitation, harassment, bullying, threats, violence, hate, impersonation, scams, spam, private information, self-harm encouragement, illegal activity, or any unsafe behavior.

2. You must meet the legal age and local eligibility requirements for creating an account and using interactive music features in your region.

3. Do not use song rounds, profile moments, activity groups, or room activity to mislead others, pressure users, attack participants, or disrupt the experience.

4. Tinkie provides Report and Block tools. Users can flag objectionable content and block abusive users from profile pages, activity pages, short clip pages, and room screens.

5. Tinkie may review reported activity, hide or remove content, restrict features, block access, or ban accounts that violate these rules. Serious or repeated violations may result in permanent removal.

By tapping I agree, you accept the Terms of Use and Privacy Policy and agree to keep Tinkie safe for music games and relaxed voice play.
"""

    static let termsTuneBody = """
Tinkie – Voice Songs Terms of Use

Welcome to Tinkie – Voice Songs. Tinkie is designed as an entertainment app for music guessing, singing clues, song challenges, profile moments, and relaxed voice-themed party experiences. Before registering or logging in, you must agree to these Terms of Use and the EULA shown in the app. By creating an account, signing in, browsing activities, choosing an avatar, joining a song challenge, or using any feature in Tinkie, you agree to follow these Terms of Use and all applicable laws in your region.

You may use Tinkie only if you meet the minimum age and legal eligibility requirements where you live. If your local law requires consent from a parent, guardian, or other authorized person, you are responsible for obtaining that consent before using the app. You must provide information that is accurate enough for a local profile experience and you must not impersonate another person, misrepresent your identity, or use another user's account.

Tinkie is built around playful music discovery. Tinkie has no tolerance for objectionable content or abusive users. You agree not to post, upload, perform, suggest, or promote content that involves child exploitation or harm, sexual content involving minors, harassment, bullying, threats, hate, violence, self-harm encouragement, illegal activity, fraud, spam, deception, private information, or any content that is unsafe, abusive, or inconsistent with a respectful song challenge environment. You must not use Tinkie to pressure users, mislead players, disrupt activity rounds, attack participants, or turn music features into harmful behavior.

You are responsible for the names, avatars, captions, moments, and other content you create or select. You must not upload or use images, music, lyrics, recordings, marks, or other materials unless you have the right to use them. Tinkie may display demo activity data, sample song challenge content, and local profile information to simulate a real app experience; this does not grant you commercial rights to third-party music or media.

Tinkie provides report and block tools so users can respond to unwanted or harmful behavior. Users can flag objectionable content from activity lists, profile pages, short clip areas, detail pages, and room screens. Users can also block abusive users or hide unsafe content through the Block action. We may review reported activity, hide content, restrict local features, remove access, or ban accounts that violate these Terms. Serious or repeated violations may result in permanent restrictions. You must not abuse reporting tools or submit false reports to interfere with another user's experience.

This version of Tinkie primarily uses local device storage to create a realistic account and profile flow. Signing out clears the current sign-in state but does not automatically delete locally registered profile records. You are responsible for protecting your device, password, and account access. If you have questions about these Terms, safety, content handling, or account concerns, contact us at tinkie@gmail.com.
"""

    static let privacyTuneBody = """
Tinkie – Voice Songs Privacy Policy

Tinkie – Voice Songs respects your privacy and is designed to use only the information needed to provide a music guessing, voice-themed party, song challenge, and profile moment experience. This Privacy Policy explains what information may be handled by the app, why it is used, and how you can contact us about privacy questions.

Tinkie may store account and profile information locally on your device, including your email address, nickname, user ID, sign-in state, profile image reference, follower and following counts, balance display data, activity participation records, profile moments, report choices, block choices, and other local settings needed to make the app feel complete and consistent after restart. This data is used to restore your account session, show your Me page, display song challenge activity, support local interactions, and provide a realistic app experience without requiring a commercial server.

When you choose a profile avatar during registration, Tinkie may request access to your camera or photo library. Camera access is used only so you can take a local avatar photo. Photo library access is used only so you can choose an image for your local profile. You can refuse these permissions and continue using a default Tinkie avatar. Selected avatar images are saved locally on your device for profile display. Tinkie does not use these permissions for advertising tracking, background scanning, unrelated collection, or identity verification.

Tinkie may include user-style content areas such as activity options, profile moments, profile pages, room screens, and report or block flows. To support safety , the app may retain local signals related to reports, blocked users, hidden content, and activity decisions. These signals help show safer local content, demonstrate that users can flag objectionable content, and keep blocked or abusive users away from the local experience. Users should not share sensitive personal information through nicknames, avatars, captions, or other profile fields.

Tinkie does not tolerate objectionable content or abusive conduct. If users report content or block a user, the app may store that safety choice locally so the same content, account, or activity can be hidden or restricted on that device. These safety records are used for moderation simulation, review readiness, and user protection within the app experience.

This version does not connect to a commercial backend and does not sell your personal information. It does not intentionally share your local profile records with advertisers, data brokers, or unrelated third parties. If a future version adds server sync, analytics, crash reporting, cloud moderation, or other third-party services, we will update the app description or policy as needed and explain the relevant data use.

Signing out only clears your current login state and does not automatically erase local registered profiles. If you want help with privacy questions, account information, deletion requests, consent withdrawal, or data handling concerns, contact us at tinkie@gmail.com. We will review reasonable requests according to applicable law, safety requirements, and technical limits of local device storage.
"""
}
