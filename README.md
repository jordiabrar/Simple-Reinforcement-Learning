# Proyek Reinforcement Learning: Q-Learning di GridWorld

Proyek ini merupakan implementasi algoritma Q-Learning untuk melatih agen dalam lingkungan GridWorld sederhana menggunakan bahasa pemrograman Julia. Proyek ini memanfaatkan paket-paket:
- **ReinforcementLearning.jl**
- **ReinforcementLearningEnvironments.jl**
- **ReinforcementLearningCore.jl**
- **Plots.jl**

## Deskripsi Proyek
Dalam proyek ini, sebuah agen dilatih untuk menavigasi lingkungan GridWorld. Agen menggunakan algoritma Q-Learning dengan strategi epsilon-greedy untuk menyeimbangkan eksplorasi dan eksploitasi. Proses pelatihan dilakukan selama 500 episode, di mana total reward setiap episode dihitung dan divisualisasikan untuk memantau perkembangan pembelajaran. Setelah pelatihan, agen dievaluasi tanpa eksplorasi (ε = 0) untuk menunjukkan performa yang telah dipelajari.

## Fitur Utama
- **Lingkungan GridWorld Sederhana:** Menggunakan environment `BasicGridWorld()` yang sudah tersedia.
- **Algoritma Q-Learning:** Implementasi Q-Learning dengan learning rate (α = 0.1) dan discount factor (γ = 0.99).
- **Strategi Epsilon-Greedy:** Untuk memilih aksi secara seimbang antara eksplorasi dan eksploitasi.
- **Visualisasi Reward:** Plot grafik reward total per episode selama pelatihan.
- **Evaluasi Agen:** Menjalankan evaluasi agen tanpa eksplorasi untuk melihat hasil pembelajaran.

## Prasyarat
Pastikan Anda telah menginstal [Julia](https://julialang.org/) dan paket-paket yang diperlukan. Untuk menginstal paket yang diperlukan, jalankan perintah berikut di REPL Julia:

```julia
using Pkg
Pkg.add("ReinforcementLearning")
Pkg.add("ReinforcementLearningEnvironments")
Pkg.add("ReinforcementLearningCore")
Pkg.add("Plots")
```

## Cara Menjalankan Proyek

1. **Clone Repository:**
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Jalankan Script:**
   Simpan kode proyek di file, misalnya `main.jl`. Kemudian, buka REPL Julia dan jalankan:
   ```julia
   include("main.jl")
   ```
   Script ini akan menjalankan pelatihan agen selama 500 episode dan mencetak total reward setiap 50 episode. Setelah pelatihan selesai, agen akan dievaluasi, dan langkah-langkah aksi serta reward yang diterima akan ditampilkan.

## Struktur Proyek
- `main.jl` : Berisi kode implementasi pelatihan dan evaluasi agen di lingkungan GridWorld.
- `README.md` : Dokumentasi dan panduan proyek ini.
- File tambahan (jika ada) dapat ditambahkan untuk keperluan lain seperti konfigurasi, data, atau dokumentasi lebih lanjut.

## Penjelasan Kode
- **Definisi Lingkungan:**  
  Lingkungan didefinisikan dengan:
  ```julia
  env = BasicGridWorld()
  ```
- **Definisi Agen dan Q-Learning:**  
  Agen dibuat menggunakan:
  ```julia
  agent = Agent(
      policy = EpsilonGreedyPolicy(ϵ=0.1),
      learner = QLearner(α=0.1, γ=0.99),
      explorer = EpsilonGreedyExplorer(ϵ=0.1)
  )
  ```
- **Pelatihan Agen:**  
  Fungsi `run_episode!` menjalankan satu episode pelatihan, melakukan reset lingkungan, memilih aksi, mendapatkan reward, dan mengupdate agen berdasarkan pengalaman.
- **Visualisasi Reward:**  
  Menggunakan paket `Plots` untuk menampilkan grafik reward selama pelatihan:
  ```julia
  plot(1:num_episodes, reward_history, xlabel="Episode", ylabel="Total Reward", title="Training Reward over Episodes", legend=false)
  ```
- **Evaluasi Agen:**  
  Setelah pelatihan, nilai epsilon diubah menjadi 0 untuk mengevaluasi performa agen tanpa adanya eksplorasi:
  ```julia
  agent.policy.ϵ = 0.0
  ```

## Catatan
- Anda dapat menyesuaikan parameter pelatihan (jumlah episode, nilai ε, learning rate, dll) sesuai kebutuhan.
- Proyek ini merupakan contoh sederhana yang dapat dikembangkan lebih lanjut untuk aplikasi reinforcement learning yang lebih kompleks.

