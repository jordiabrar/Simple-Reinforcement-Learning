using ReinforcementLearning
using ReinforcementLearningEnvironments
using ReinforcementLearningCore
using Plots

# Definisikan lingkungan: Kita akan menggunakan environment GridWorld yang sudah tersedia.
env = BasicGridWorld()  # Lingkungan grid world sederhana

# Definisikan agen dengan Q-Learning
# Kita menggunakan fungsi QLearner bawaan dari ReinforcementLearning.jl
agent = Agent(
    policy = EpsilonGreedyPolicy(ϵ=0.1),       # Eksplorasi epsilon-greedy dengan epsilon 0.1
    learner = QLearner(α=0.1, γ=0.99),           # Q-learning dengan learning rate (α) dan discount factor (γ)
    explorer = EpsilonGreedyExplorer(ϵ=0.1)        # Penjelajah epsilon-greedy
)

# Parameter pelatihan
num_episodes = 500
reward_history = zeros(num_episodes)

# Fungsi untuk menjalankan satu episode pelatihan
function run_episode!(env, agent)
    total_reward = 0.0
    reset!(env)  # Reset environment ke kondisi awal
    done = is_terminated(env)
    while !done
        s = state(env)                         # Dapatkan state saat ini
        a = agent(env, s)                      # Agen memilih aksi berdasarkan policy
        r = step!(env, a)                      # Lakukan aksi dan dapatkan reward
        total_reward += r
        done = is_terminated(env)              # Periksa apakah episode selesai
        # Update agen dengan pengalaman (s, a, r, done)
        agent(env, s, a, r, done)
    end
    return total_reward
end

# Pelatihan agen
for episode in 1:num_episodes
    reward_history[episode] = run_episode!(env, agent)
    if episode % 50 == 0
        println("Episode $episode, Total Reward: $(reward_history[episode])")
    end
end

# Visualisasi reward selama pelatihan
plot(1:num_episodes, reward_history, xlabel="Episode", ylabel="Total Reward", title="Training Reward over Episodes", legend=false)

# Evaluasi agen pada satu episode (tanpa eksplorasi) dengan epsilon = 0
agent.policy.ϵ = 0.0
reset!(env)
done = is_terminated(env)
println("\nEvaluating trained agent:")
while !done
    s = state(env)
    a = agent(env, s)
    r = step!(env, a)
    println("State: ", s, " | Action: ", a, " | Reward: ", r)
    done = is_terminated(env)
end

println("\nTraining completed. Agent has learned to navigate the GridWorld!")
